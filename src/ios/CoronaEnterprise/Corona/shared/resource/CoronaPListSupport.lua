--------------------------------------------------------------------------------
---- CoronaPListSupport.lua
----
---- Code to update an iOS app's Info.plist with info from an app's build.settings
----
---- Copyright (c) 2014 Corona Labs Inc. All rights reserved.
----
---- Reviewers:
---- 		Perry
----
----------------------------------------------------------------------------------

local json = require("json")

-- Double quote a string escaping backslashes and any double quotes
local function quoteString( str )
	str = str:gsub('\\', '\\\\')
	str = str:gsub('"', '\\"')
	return "\"" .. str .. "\""
end

local buildDebug = os.getenv("CORONA_BUILD_DEBUG")

CoronaPListSupport = {}

function CoronaPListSupport.modifyPlist( options )
	local infoPlistFile = options.appBundleFile .. "/Info.plist"
	local tmpJSONFile = os.tmpname()
	local infoPlist = nil

    print("Creating Info.plist...")

	-- Convert the Info.plist to JSON and read it in
	os.execute( "plutil -convert json -o '"..tmpJSONFile.."' "..infoPlistFile)

	local jsonFP, errorMsg = io.open(tmpJSONFile, "r")
	if jsonFP ~= nil then

		local jsonDataStr = jsonFP:read("*a")

		jsonFP:close()

		infoPlist, errorMsg = json.decode( jsonDataStr );

		if infoPlist == nil then
			print("Error: failed to load "..tmpJSONFile..": "..errorMsg)
			print("JSON: "..tostring(jsonDataStr))
		end
	else
		print("Error: failed to open modifyPlist input file '"..tmpJSONFile.."': "..errorMsg)
	end
    
    os.remove(tmpJSONFile)

	-- infoPlist now contains a Lua table representing the Info.plist

	if buildDebug then
		print("Base Info.plist: " .. json.encode(infoPlist, { indent = true }))
	end

	if options.bundledisplayname then
		infoPlist.CFBundleDisplayName = options.bundledisplayname
	end
	if options.bundleexecutable then
		infoPlist.CFBundleExecutable = options.bundleexecutable
	end
	if options.bundleid then
		infoPlist.CFBundleIdentifier = options.bundleid
	end
	if options.bundlename then
		infoPlist.CFBundleName = options.bundlename
	end
	if options.corona_build_id then
		infoPlist.CoronaSDKBuild = options.corona_build_id
	end

	-- The behavior here needs to work for both Xcode Enterprise builds and server Simulator builds
	if infoPlist.UIDeviceFamily == nil or options.targetDevice ~= nil then
		-- If the user specified iPhone or iPad only, modify the plist to not do Universal
		local isolatedTargetDevice = options.targetDevice

		if isolatedTargetDevice == nil then
			isolatedTargetDevice = 127 -- kIOSUniversal, see platform/shared/Rtt_TargetDevice.h
		end

		-- The Obj-C code uses mask bits to flag whether the target is building for device or Xcode simulator.
		-- Since we don't have bitwise operations in Lua, we do things the hard way.
		if isolatedTargetDevice >= 128 then
			-- removes the Xcode simulator flag
			isolatedTargetDevice = isolatedTargetDevice - 128
		end
		if isolatedTargetDevice == 0 or isolatedTargetDevice == 1 then
			-- Corona uses 0 and 1 for iPhone and iPad, but UIDeviceFamily uses 1 and 2
			infoPlist.UIDeviceFamily = { isolatedTargetDevice+1 }
		else
			-- "universal" just means "both iPhone and iPad"
			infoPlist.UIDeviceFamily = { 1, 2 }
		end
	end

	local bundleVersionSource = "not set"
	local bundleShortVersionStringSource = "not set"

	-- We process app Info.plists effectively twice, once when the templates are built and once when
	-- the app itself is built. The meta Info.plist has the place holders prefixed with "TEMPLATE_"
	-- so when we see that we replace it with the normal placeholders.
	if infoPlist.CFBundleVersion == "@TEMPLATE_BUNDLE_VERSION@" then
		infoPlist.CFBundleVersion = "@BUNDLE_VERSION@"
		infoPlist.CFBundleShortVersionString = "@BUNDLE_SHORT_VERSION_STRING@"
	else
		-- Only set these if they are not already set (which may happen in Enterprise builds)
		if infoPlist.CFBundleVersion == nil or infoPlist.CFBundleVersion == "@BUNDLE_VERSION@" then
			-- Apple treats this the build number so, if it hasn't been specified in the build.settings, we
			-- set it to the current date and time which is unique for the app and human readable
			bundleVersionSource = (infoPlist.CFBundleVersion == "@BUNDLE_VERSION@") and "set by Simulator" or "set by Info.plist"
			infoPlist.CFBundleVersion = os.date("%Y.%m.%d%H%M")
		end

		local version = options.bundleversion or "1.0.0"
		if infoPlist.CFBundleShortVersionString == nil or infoPlist.CFBundleShortVersionString == "@BUNDLE_SHORT_VERSION_STRING@" then
			bundleShortVersionStringSource = (infoPlist.CFBundleShortVersionString == "@BUNDLE_SHORT_VERSION_STRING@") and "set in Build dialog" or "set by Info.plist"
			infoPlist.CFBundleShortVersionString = version
		end
	end

	-- build.settings
	local defaultSettings = {
		orientation =
		{
			default = "portrait"
		}
	}
	local settings = options.settings or defaultSettings
	if settings then
		-- cross-platform settings
		local orientation = settings.orientation or defaultSettings.orientation
		if orientation then
			local defaultOrientation = orientation.default
			local supported = {}
			if defaultOrientation then
				local value = "UIInterfaceOrientationPortrait"
				if "landscape" == defaultOrientation or "landscapeRight" == defaultOrientation then
					value = "UIInterfaceOrientationLandscapeRight"
				elseif "landscapeLeft" == defaultOrientation then
					value = "UIInterfaceOrientationLandscapeLeft"
				end

				table.insert( supported, value )
				infoPlist.UIInterfaceOrientation = value
			end

			infoPlist.ContentOrientation = nil
			local contentOrientation = orientation.content
			if contentOrientation then
				local value
				if "landscape" == contentOrientation or "landscapeRight" == contentOrientation then
					value = "UIInterfaceOrientationLandscapeRight"
				elseif "landscapeLeft" == contentOrientation then
					value = "UIInterfaceOrientationLandscapeLeft"
				elseif "portrait" == contentOrientation then
					value = "UIInterfaceOrientationPortrait"
				end

				if value then
					infoPlist.ContentOrientation = value
				end
			end

			infoPlist.CoronaViewSupportedInterfaceOrientations = nil
			local supportedOrientations = orientation.supported
			if supportedOrientations then
				local toUIInterfaceOrientations =
				{
					landscape = "UIInterfaceOrientationLandscapeRight",
					landscapeRight = "UIInterfaceOrientationLandscapeRight",
					landscapeLeft = "UIInterfaceOrientationLandscapeLeft",
					portrait = "UIInterfaceOrientationPortrait",
					portraitUpsideDown = "UIInterfaceOrientationPortraitUpsideDown",
				}

				for _,v in ipairs( supportedOrientations ) do
					local value = toUIInterfaceOrientations[v]
					if value then
						-- Add only unique values
						local found
						for _,elem in ipairs( supported ) do
							if elem == value then
								found = true
								break
							end
						end

						if not found then
							table.insert( supported, value )
						end
					end
				end
			end

			infoPlist.CoronaViewSupportedInterfaceOrientations = supported
			infoPlist.UISupportedInterfaceOrientations = supported
		end

		-- add'l custom plist settings specific to iPhone
		local buildSettingsPlist = settings.iphone and settings.iphone.plist

		if buildSettingsPlist then
			--print("Adding custom plist settings: ".. json.encode(buildSettingsPlist))
			--print("buildSettingsPlist: "..json.encode(buildSettingsPlist))
			--print("infoPlist (before): "..json.encode(infoPlist))

			if buildSettingsPlist.CFBundleShortVersionString then
				bundleShortVersionStringSource = "set in build.settings"
			end
			if buildSettingsPlist.CFBundleVersion then
				bundleVersionSource = "set in build.settings"
			end

			for k, v in pairs(buildSettingsPlist) do
                local valuestr = ""
                if type(v) == "table" then
                    valuestr = json.encode(v)
                else
                    valuestr = tostring(v)
                end
				print("    adding extra plist setting "..k..": "..valuestr)
				infoPlist[k] = v
			end

			--print("infoPlist (after): "..json.encode(infoPlist, {indent = true}))
		end

	end

	if buildDebug then
		print("Final Info.plist: " .. json.encode(infoPlist, { indent = true }))
	end

	local outFP, errorString = io.open( tmpJSONFile, "w" )
	if outFP ~= nil then
		outFP:write( json.encode(infoPlist, {indent = true}) )
		outFP:close()

		-- Convert the JSON plist into an XML plist
		os.execute("plutil -convert xml1 -o "..infoPlistFile.." '"..tmpJSONFile.."'")
	else
		print("modifyPlist: failed to open output file '"..tmpJSONFile.."': "..errorString)
	end

	os.remove(tmpJSONFile)

	-- Do some trick formatting on the output strings
	local fmt = "%-" .. tostring(string.len(infoPlist.CFBundleVersion)) .. "s"
	print("Application version information:")
	print("    Version: ".. string.format(fmt, tostring(infoPlist.CFBundleShortVersionString)) .." [CFBundleShortVersionString] (".. bundleShortVersionStringSource ..")")
	print("      Build: ".. tostring(infoPlist.CFBundleVersion).." [CFBundleVersion] (".. bundleVersionSource .. ")")
end

return CoronaPListSupport
