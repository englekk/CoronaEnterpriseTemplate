----------------------------------------------------------------------------------------------------
-- Creates a "build.properties" file to be sent to the Corona build server.
-- Used to generate an "AndroidManifest.xml" file.
----------------------------------------------------------------------------------------------------

-- Creates a "build.properties" file with the given settings and the "build.settings" file.
-- Returns nil if succeeded. Returns an error message string if there was a failure.
function androidCreateProperties(destinationDirectory, packageName, projectDirectory, versionCode, versionName, targetedAppStore)
	local json = require("json")
	local lfs = require('lfs')
	local errorMessage = nil

	-- Make sure that the optional arguments are set to valid values.
	if not versionCode then
		versionCode = 1
	end
	if not versionName then
		versionName = "1.0"
	end
	if not targetedAppStore then
		targetedAppStore = "none"
	end

	-- Load the "build.settings" file, if it exists.
	if projectDirectory and projectDirectory ~= "" then
		errorMessage = nil
		local buildSettingsFilePath = projectDirectory .. "/build.settings"
		local buildSettingsFileHandle = io.open( buildSettingsFilePath, "r" )
		if buildSettingsFileHandle then
			local chunk, errorMessage = loadfile( buildSettingsFilePath )
			if chunk then
				chunk()
			end
			buildSettingsFileHandle:close()
		end
		if errorMessage then
			if ("string" == type(errorMessage)) and (string.len(errorMessage) > 0) then
				errorMessage = 'The "build.settings" file contains the following error: ' .. errorMessage
			else
				errorMessage = 'Failed to access the "build.settings" file.'
			end
			return errorMessage
		end
	end

	-- Create the build properties from the given arguments and "build.settings".
	local buildProperties = {}
	buildProperties.packageName = packageName
	buildProperties.versionCode = versionCode
	buildProperties.versionName = versionName
	buildProperties.targetedAppStore = targetedAppStore
	if type(settings) == "table" then
		buildProperties.buildSettings = settings
	end

	-- Create the "build.properties" file.
	errorMessage = nil
	local buildPropertiesFilePath = destinationDirectory .. "/build.properties"
	local buildPropertiesFileHandle, errorMessage = io.open( buildPropertiesFilePath, "wb" )
	if not buildPropertiesFileHandle then
		if ("string" == type(errorMessage)) and (string.len(errorMessage) > 0) then
			return errorMessage
		else
			return "Failed to create file: "..buildPropertiesFilePath
		end
	end
	buildPropertiesFileHandle:write(json.encode(buildProperties))
	buildPropertiesFileHandle:close()

	-- Create the build.xml file exclusion list
	-- (note that build.xml needs the file to exist so we always create it
	-- even if it's empty)
	errorMessage = nil
	local excludesFilePath = destinationDirectory .. "/excludesfile.properties"
	local excludesFileHandle, errorMessage = io.open( excludesFilePath, "wb" )
	if not excludesFileHandle then
		if ("string" == type(errorMessage)) and (string.len(errorMessage) > 0) then
			return errorMessage
		else
			return "Failed to create file: "..excludesFilePath
		end
	end

	if settings and settings.excludeFiles then
		-- we have actual files to exclude
		print("Excluding specified files from build: ")
		for platform,excludes in pairs(settings.excludeFiles) do
			if platform == "all" or platform == "android" then
				for index,pattern in ipairs(excludes) do
					print("   excluding: "..pattern)
					-- Add '/**' to directories to better meet user expectations of globbing behavior
					attrs = lfs.attributes(projectDirectory.."/"..pattern)
					if attrs and attrs.mode == "directory" then
						pattern = pattern .. "/**"
					end
					-- Prepend directory wildcard so internal app structure is hidden
					pattern = "**/" .. pattern
					excludesFileHandle:write(pattern.."\n")
				end
			end
		end
	end

	excludesFileHandle:close()

	-- Return nil to indicate that the we succeeded in creating the file.
	return nil
end


-- If "arg" was defined, then this script was called from the command line for local Android builds.
if arg then
	-- If no valid arguments have been received, then explain how to use this script.
	if (arg[1] == nil) or (arg[2] == nil) then
		print("USAGE: " .. arg[0] .. " destinationDirectory packageName [projectDirectory [versionCode [versionName [targetedAppStore]]]]")
		os.exit( -1 )
	end

	-- Create the "build.properties" file.
	local errorMessage = androidCreateProperties(arg[1], arg[2], arg[3], arg[4], arg[5], arg[6])
	if errorMessage then
		local logMessage = 'ERROR: Failed to create the "build.properties" file. '
		if ("string" == type(errorMessage)) and (string.len(errorMessage) > 0) then
			logMessage = logMessage .. errorMessage
		end
		print(logMessage)
		os.exit(-1)
	end
end

