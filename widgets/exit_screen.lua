--Library
----------------------------------------
local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local util      = require("utilities")
local wibox     = require("wibox")


--Variables
-------------------------------------------------------------------------
local exit_screen           = {}
local exit_screen_grabber   = nil

local width                 = screen[mouse.screen].geometry.width
local height                = screen[mouse.screen].geometry.height

local height_exitscreen     = height / 2.8
local width_exitscreen      = width / 2.5
local positionx             = (width - width_exitscreen) / 2
local positiony             = (height - height_exitscreen) / 2

local alert_icon            = wibox.widget.imagebox(beautiful.exit_screen.icon)
local warning_text          = util.label("WARNING SYSTEM", beautiful.exit_screen.title)
local msg_widget            = util.label("DO YOU WANT TO EXIT FROM THE CURRENT SESSION  ?", beautiful.exit_screen.text)

-- functions
------------------------------------
function exit_screen.quit()
    awesome.quit()
end

function exit_screen.hide()
    exit_screen.widg.visible = false
end

function exit_screen.show()
    --Play sound
    -------------------------------------------------------------
    if not _G.dont_disturb then
        -- Add Sound fx to notif
        -- Depends: libcanberra
        awful.spawn('canberra-gtk-play -i window-attention', false)
    end

    -- run keygrabber
    ---------------------------------------------------------------
    exit_screen_grabber =
    awful.keygrabber.run(function(_, key, event)
        if event == 'release' then
            return
        end
        if key == 'o' or key == 'y' then
            exit_screen.quit()
        elseif key == 'Escape' or key == 'q' or key == 'x' then
            exit_screen.hide()
        else
            awful.keygrabber.stop(exit_screen_grabber)
        end
    end)
    exit_screen.widg.visible = true
end



-- Create the widget
-----------------------------------------------
exit_screen.widg = wibox({
    x = positionx,
    y = positiony,
    border_width = 15,
    border_color = beautiful.color.bg,
    ontop = true,
    visible = hide,
    type = "dock",
    height = height_exitscreen,
    width = width_exitscreen,
    bg = beautiful.color.black,
    shape = util.shape.rectangle.second_style
})

-- BTN 1
-------------------------------------------------------------
local btn_1 = util.button("YES - EXIT")
btn_1:buttons(gears.table.join(awful.button({}, 1, function()
    exit_screen.quit()
end)))

-- BTN 2
-------------------------------------------------------------
local btn_2 = util.button("CANCEL")
btn_2:buttons(gears.table.join(awful.button({}, 1, function()
    exit_screen.hide()
end)))




exit_screen.widg:setup {
    {
        {
            {
                alert_icon,
                warning_text,
                layout = wibox.layout.align.horizontal,
            },
            top = 20,
            left = 35,
            bottom = 0,
            widget = wibox.container.margin
        },
        fg = beautiful.color.white,
        widget = wibox.container.background
    },
    {
        {
            msg_widget,
            layout = wibox.layout.align.horizontal
        },
        top = 10,
        right = 10,
        left = 10,
        bottom = 10,
        widget = wibox.container.margin
    },
    {
        {
            btn_1,
            btn_2,
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        top = 20,
        right = 10,
        left = 35,
        bottom = 20,
        widget = wibox.container.margin
    },
    layout = wibox.layout.flex.vertical
}

return exit_screen
