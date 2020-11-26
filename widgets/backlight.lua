-- Library
--------------------------------------------
local beautiful 	= require("beautiful")
local setmetatable 	= setmetatable
local gears		 	= require("gears")
local unpack 		= unpack or table.unpack
local util 			= require("utilities")
local wibox     	= require("wibox")


-----------------------------------------------------------------------------------------------------------------------
local volume = { mt = {} }

-----------------------------------------------------------------------------------------------------------------------
function volume.getValue()
	-- get current brightness value
	local stdout        = util.read.output("cat /sys/class/backlight/intel_backlight/brightness")
	-- maximuze value is 937 
	return tonumber(string.match(stdout, '(%d+)'))/937
end

-----------------------------------------------------------------------------------------------------------------------
function volume.new()
	--------------------------------------------------------------------------------
	local style =  { width   = 150, margin = { 5, 0, 5, 5 } }
	--------------------------------------------------------------------------------
	local text = util.background("BRIGHTNESS","roboto bold 10 ",beautiful.color.orange,"#000000")
	--------------------------------------------------------------------------------
	local layout = wibox.layout.fixed.horizontal()
    layout:add(text)
	--------------------------------------------------------------------------------
	local dash = util.progressbar.horizontal()

	local t = gears.timer({ timeout = 2 })
	t:connect_signal("timeout", function()
		dash:set_value(volume.getValue())
	end)
	t:start()

	layout:add(wibox.container.margin(dash, unpack(style.margin)))
	--------------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "exact", style.width)

	return widg
end
-----------------------------------------------------------------------------------------------------------------------
function volume.mt:__call(...)
	return volume.new(...)
end
return setmetatable(volume, volume.mt)