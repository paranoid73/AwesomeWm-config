-- Standard awesome library
local awful         =   require("awful")
local gears         =   require("gears")
local beautiful     =   require("beautiful")

-- custom library
local util          =   require("utilities")
local hotkeys       =   require("awful.hotkeys_popup.widget")

local module = hotkeys.new({
        hide_without_description = false,
        width   = screen[mouse.screen].geometry.width/1.5,
        height  = screen[mouse.screen].geometry.height/1.5,
        bg      = beautiful.color.black,
        border_width = 10,
        border_color = beautiful.color.bg,
        font        = "Roboto 11",
        shape   = util.shape.rectangle.first_style
})

module:show_help()

return module