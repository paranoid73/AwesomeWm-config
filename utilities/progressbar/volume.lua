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

-----------------------------------------------------------------------------------------------------------------------
function progressbar.new()
	--------------------------------------------------------------------------------
	local style =  {
		plain = true,
		bar   = { width = 5 , num = 4 },
		color = { main = beautiful.color.orange , gray = beautiful.color.gray }
	}
	--------------------------------------------------------------------------------
	local widg = wibox.widget.base.make_widget()
	widg._data = { value = 0, cnum = 0 }

	-- Fit
	------------------------------------------------------------
	function widg:fit(_, width, height)
		return width, height
	end

	-- set value
	function widg:set_value(x)
		self._data.value = x < 1 and x or 1
		local num = math.ceil(widg._data.value * style.bar.num)
		if num ~= self._data.cnum then
			self._data.cnum = num
			self:emit_signal("widget::redraw_needed")
		end
	end
	-- Draw
	------------------------------------------------------------
    function widg:draw(_, cr, width, height)
        local positionx = 0
        local positiony = 0
        local h         = height / style.bar.num
        for i = 1, style.bar.num do
            positionx = positionx + 8
			positiony = height / 2 - h/2
            cr:set_source(color(i > self._data.cnum and style.color.gray or style.color.main))
			cr:rectangle(positionx, positiony, style.bar.width, h)
			cr:fill()

			h = h + 10
		end
	end
	--------------------------------------------------------------------------------
	return widg
end

-----------------------------------------------------------------------------------------------------------------------
function progressbar.mt:__call(...)
	return progressbar.new(...)
end

return setmetatable(progressbar, progressbar.mt)