local setmetatable 	= setmetatable
local unpack 		= unpack or table.unpack
local awful         = require("awful")
local wibox     	= require("wibox")
local beautiful 	= require("beautiful")
local gears		 	= require("gears")
local util 			= require("utilities")


-------------------------------------------------------
local profile = { mt = {} }
-------------------------------------------------------
local function default_style()
	local style = {
		width   = 130,
	}
	return style
end


function profile.getUserName()
	local stdout        = util.read.output("whoami")
	return tostring(string.upper(stdout))
end

------------------------------------------------------------------------------
function profile.new()
	-- Initialize vars
	--------------------------------------------------------------------------
	local style = default_style()
	--------------------------------------------------------------------------
	local text = util.background(profile.getUserName())
	--------------------------------------------------------------------------
	local layout = wibox.layout.fixed.horizontal()
    layout:add(text)
	--------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "max", style.width)

	return widg
end

------------------------------------------------------------------------------
function profile.mt:__call(...)
	return profile.new(...)
end
return setmetatable(profile, profile.mt)