local Class = {}

--- sep를 이용해 문자열 나누기
-- @param str
-- @param sep
-- @return
Class.split = function (str, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    str:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

return Class