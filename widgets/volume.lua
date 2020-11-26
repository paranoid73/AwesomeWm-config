-- LIbrary
------------------------------------------------------------
local awful         = require("awful")
local wibox     	= require("wibox")
local beautiful 	= require("beautiful")
local gears		 	= require("gears")
local unpack		= unpack
local read_cmd 		= require("utilities.read")
local progressbar   = require("utilities.progressbar")

-- Variable
---------------------------------------------------------------
local volume = { mt = {} }
local setmetatable 	= setmetatable

-- style
----------------------------------------------------------------
local function default_style()
	local style = {
		width   = 60,
		dmargin = { -2, 0, 0, 0 },
	}
	return style
end


function volume.getValue()
	local CMD_VL      	= "amixer -D pulse sget Master"
	local stdout        = read_cmd.output(CMD_VL)
	local volume 		= string.match(stdout, "(%d?%d?%d)%%")
	return tonumber(string.format("% 3d", volume)) / 100
end

-- Increase volume
----------------------------------------------------
function volume.increase()
	awful.spawn('amixser set Master 10+', false)
end

-- Decrease volume
-----------------------------------------------
function volume.decrease()
	awful.spawn('amixser set Master 10-', false)
end

-----------------------------------------------------
function volume.new()
	-- Initialize vars
	--------------------------------------------------------------------------------
	local style = default_style()
	--------------------------------------------------------------------------------

	-- Add icon
	----------------------------------------------
	local icon 		= wibox.widget.imagebox(beautiful.audio.on)
	local layout 	= wibox.layout.fixed.horizontal()
	layout:add(icon)

	-- Draw progress bar
	-----------------------------------------------------------
	local dash = progressbar.volume()

	local t = gears.timer({ timeout = 5 })
	t:connect_signal("timeout", function()
		dash:set_value(volume.getValue())
	end)
	t:start()
	--------------------------------------------------------------------------------
	layout:add(wibox.container.margin(dash, style.dmargin))
	--------------------------------------------------------------------------------
	local widg = wibox.container.constraint(layout, "max", style.width)
	
	return widg
end

------------------------------------------------------------------
function volume.mt:__call(...)
	return volume.new(...)
end


return setmetatable(volume, volume.mt)