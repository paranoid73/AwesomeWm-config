-----------------------------------------------------------------------------------------------------------------------
-- Horizontal progresspar
-----------------------------------------------------------------------------------------------------------------------

local setmetatable  = setmetatable
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local color         = require("gears.color")



-- Initialize tables for module
-----------------------------------------------------------------------------------------------------------------------
local progressbar = { mt = {} }

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
-- Create a new progressbar widget
-- @param style Table containing colors and geometry parameters for all elemets
-----------------------------------------------------------------------------------------------------------------------
function progressbar.new(style)

	-- Initialize vars
	--------------------------------------------------------------------------------
	style =  {
		plain = true,
		bar   = { width = 5, num = 5 },
		color = { main = "#3bc576", gray = beautiful.color.gray }
	}


	-- Create custom widget
	--------------------------------------------------------------------------------
	local widg = wibox.widget.base.make_widget()
	widg._data = { value = 0, cnum = 0 }

	-- User functions
	------------------------------------------------------------
	function widg:set_value(x)
		self._data.value = x < 1 and x or 1
		local num = math.ceil(widg._data.value * style.bar.num)

		if num ~= self._data.cnum then
			self._data.cnum = num
			self:emit_signal("widget::redraw_needed")
		end
	end

	-- Fit
	------------------------------------------------------------
	function widg:fit(_, width, height)
		return width, height
	end

	-- Draw
	------------------------------------------------------------
	function widg:draw(_, cr, width, height)
		local wstep = (width - style.bar.width) / (style.bar.num - 1)
		local hstep = height / style.bar.num
		--self._data.cnum = math.ceil(widg._data.value * style.bar.num)

		for i = 1, style.bar.num do
			cr:set_source(color(i > self._data.cnum and style.color.gray or style.color.main))
			cr:rectangle((i - 1) * wstep, height, style.bar.width,  style.plain and -height or - i * hstep)
			cr:fill()
		end
	end
	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call progressbar module as function
-----------------------------------------------------------------------------------------------------------------------
function progressbar.mt:__call(...)
	return progressbar.new(...)
end

return setmetatable(progressbar, progressbar.mt)