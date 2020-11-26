-------- LIBRARY
-------------------------------------------
local setmetatable = setmetatable
local beautiful = require("beautiful")
local wibox = require("wibox")
local util = require("utilities")

local module = {}

--
-----------------------------------------------------------
local function new(text, font_name, background, foreground , width)
    local wid = wibox.widget {
        {
            {
                text = text,
                font = font_name or "roboto bold 10",
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox
            },
            widget = wibox.container.margin
        },
        forced_width = width or 90,
        bg = background or beautiful.color.orange,
        fg = foreground or beautiful.color.black,
        shape = util.shape.rectangle.second_style or nil,
        widget = wibox.container.background
    }
    return wid
end

------------------------------------------------------------------------------
return setmetatable(module, { __call = function(_, ...) return new(...) end })