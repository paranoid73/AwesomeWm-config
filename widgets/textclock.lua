-----------------------------------------------------------------------------------------------------------------------
--                                               RedFlat clock widget                                                --
-----------------------------------------------------------------------------------------------------------------------
-- Text clock widget with date in tooltip (optional)
-----------------------------------------------------------------------------------------------------------------------
-- Some code was taken from
------ awful.widget.textclock v3.5.2
------ (c) 2009 Julien Danjou
-----------------------------------------------------------------------------------------------------------------------

local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local beautiful = require("beautiful")
local gears = require("gears")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local textclock = { mt = {} }

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		font  = "Roboto Bold 12",
		tooltip = {},
		color = { text = "#aaaaaa" }
	}
	return style
end

-- Create a textclock widget. It draws the time it is in a textbox.
-- @param format The time format. Default is " %a %b %d, %H:%M ".
-- @param timeout How often update the time. Default is 60.
-- @return A textbox widget
-----------------------------------------------------------------------------------------------------------------------
function textclock.new(args, style)

	-- Initialize vars
	--------------------------------------------------------------------------------
	args = args or {}
	local timeformat = args.timeformat or " %a %b %d, %H:%M "
	local timeout = args.timeout or 60
	style = default_style()

	-- Create widget
	--------------------------------------------------------------------------------
	local widg = textbox()
	widg:set_font(style.font)


	-- Set update timer
	--------------------------------------------------------------------------------
	local timer = gears.timer({ timeout = timeout })
	timer:connect_signal("timeout",
		function()
			widg:set_markup('<span color="' .. style.color.text .. '">' .. os.date(timeformat) .. "</span>")
		end)
	timer:start()
	timer:emit_signal("timeout")

	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call textclock module as function
-----------------------------------------------------------------------------------------------------------------------
function textclock.mt:__call(...)
	return textclock.new(...)
end

return setmetatable(textclock, textclock.mt)
