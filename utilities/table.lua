-- Library
-------------------------------
local awful = require("awful")

-- Variables
----------------------------
local table_ = {}

-- Merge two table to new one
------------------------------
function table_.merge(t1, t2)
	local ret = awful.util.table.clone(t1)
	for k, v in pairs(t2) do
		if type(v) == "table" and ret[k] and type(ret[k]) == "table" then
			ret[k] = table_.merge(ret[k], v)
		else
			ret[k] = v
		end
	end
	return ret
end

-- Check if deep key exists
-----------------------------
function table_.check(t, s)
	local v = t
	for key in string.gmatch(s, "([^%.]+)(%.?)") do
		if v[key] then
			v = v[key]
		else
			return nil
		end
	end
	return v
end

-- simple function for counting the size of a table
--------------------------------------------------------
function table_.Length(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
-- End
----------------------------
return table_

