pcall(require, "luarocks.loader")
-- Standard awesome library
local awful = require("awful")
local gears = require("gears")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
-- Custom library
local core = require("core")
local util = require("utilities")
local widg = require("widgets")





-- Error handling
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-------- environment
-----------------------------------------------------------------
local env = require("environment")
env:init()
require("core.rules")

-------- autostart
local autostart = require("core.autostart")
autostart.run()

-- Layouts
local layout = core.layouts
layout:init()

-- keys
local keys          = core.keys

--  Textclock
local textclock     = {}
textclock.widget    = widg.textclock()

-- battery
local battery       = {}
battery.widget      = widg.battery()

-- backlight
local backlight     = {}
backlight.widget    = widg.backlight()


-- volume
local volume    = {}
volume.widget   = widg.volume()
volume.buttons  = awful.util.table.join(
      awful.button({}, 4, function() widg.volume:increase() end),
      awful.button({}, 5, function() widg.volume:decrease() end)
)

-- systray
local tray      = {}
tray.widget     = core.systray()

tray.buttons    = awful.util.table.join(
    awful.button({}, 1, function() core.systray:toggle() end)
)

-- systray
local profile = widg.profile()

-- separator
local separator = util.separator.pad(1)

-- layouts
local al = awful.layout.layouts

-- Screen setup
awful.screen.connect_for_each_screen(function(s)
    -- wallpaper
    env.set_wallpaper(s)

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))

    awful.tag(env.taglist, s, { al[2], al[1], al[10], al[4], al[10] })

    --taglist 
    s.mytaglist = core.taglist(s)
    --- - tasklist
    s.mytasklist = core.tasklist(s)

    -- top wibar
    ----------------------------------------------------------------------------------------
    s.wibar_top = awful.wibar({ position = "top", screen = s, height = beautiful.wibar.top })
    s.wibar_top:setup
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.align.horizontal,
                env.wrapper(s.mylayoutbox, "layoutbox"),
                env.wrapper(s.mytaglist, "taglist")
            },
            {
                layout = wibox.layout.align.horizontal,
                expand = "outside",
            },
            {
                layout = wibox.layout.align.horizontal,
                env.wrapper(backlight.widget,"battery"),
                env.wrapper(battery.widget,"battery"),
                env.wrapper(volume.widget,"volume",volume.buttons)
            }
        }

    -- bottom wibar
    --------------------------------------------------------------------------------------------------
    s.wibar_bottom = awful.wibar({ position = "bottom", screen = s, height = beautiful.wibar.bottom })
    s.wibar_bottom:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(profile, "profile")
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(s.mytasklist, "tasklist")
        },
        {
            layout = wibox.layout.align.horizontal,
            env.wrapper(textclock.widget, "profile"),
            separator,
            env.wrapper(tray.widget,"profile",tray.buttons)
        }
    }
end)

-- shortened tasklist's name 
client.connect_signal("property::name", function(c)
    local client_name = c.name
    if string.len(client_name) > 35 then
        c.name = string.sub(client_name, 1, 35)
    end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    if awesome.startup
            and not c.size_hints.user_position
            and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)



