-- Library
----------------------------
local setmetatable  = setmetatable
local gears         = require("gears")
local wibox         = require("wibox")

local module        = {}

-- wibox
----------------------------
local function new(text,font_name)
    return wibox.widget{
        markup = text,
        font   = font_name or "Roboto" ,
        align  = 'center',
        valign = 'left',
        widget = wibox.widget.textbox
    }
end

------------------------------------------------------------------------------------
return setmetatable(module, { __call = function(_, ...) return new(...) end })