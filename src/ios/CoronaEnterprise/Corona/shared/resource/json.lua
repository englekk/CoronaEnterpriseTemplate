--------------------------------------------------------------------------------
---- json.lua
----
---- Wrapper for dkjson.lua that implements the defaults we want (and improves
---- a common error behavior)
----
---- Copyright (c) 2014 Corona Labs Inc. All rights reserved.
----
---- Reviewers:
---- 		Perry
----
----------------------------------------------------------------------------------

local dkjson = require "dkjson"

-- Give ourselves a different version
dkjson.version = dkjson.version .. "-1"

local decode_base = dkjson.decode
local encode_base = dkjson.encode

local function decode_override(str, pos, nullval, ...)
	-- Check for common error that gives an inscrutable message and
	-- provide a better one
	if str == nil then
		error("json.decode called with nil string")
	else
		return decode_base(str, pos, nullval, ...)
	end
end

local function encode_override(value, state)
	-- Enforce a default exception handler for data that JSON 
	-- cannot encode.  To restore the default behavior define
	-- an exception handler that calls error()
	if state == nil then
		state = {}
	end
	if state.exception == nil then
		state.exception = dkjson.encodeexception
	end

	return encode_base(value, state)
end

local function json_prettify(obj)
	-- Return a human readable JSON string representing the
	-- given Lua object or JSON string (top-level keys are sorted)

	local pos, errorMsg

	if obj == nil then
		error("json.prettify called with nil string")
	elseif type(obj) == "string" then
		-- Assume we were given a JSON string
		local len = obj:len()
		obj, pos, errorMsg = decode_base(obj)

		if errorMsg ~= nil then
			error("json.prettify: invalid input: ".. tostring(errorMsg))
			return nil
		elseif pos < len then
			print("Warning: json.prettify: extra data at end of JSON")
			return nil
		end

	elseif type(obj) ~= "table" then
		error("json.prettify takes a string or a table (got "..type(obj)..")")
		return nil
	end

	local keyorder = {}
	for k, v in pairs(obj) do
		keyorder[#keyorder + 1] = k
	end
	table.sort(keyorder)

	return encode_override(obj, { indent = true, keyorder = keyorder })
end


dkjson.decode = decode_override
dkjson.encode = encode_override
dkjson.prettify = json_prettify

return dkjson
