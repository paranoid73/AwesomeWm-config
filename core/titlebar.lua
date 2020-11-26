-----------------------------------------------------------------------------------------------------------------------
-- Titlebar config                                                     --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")


-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local titlebar = {}


function label(c, is_highlighted)
    local w = wibox.widget.textbox()
    w:set_align("center")
    w:set_font("roboto bold 10")
    w._current_color = beautiful.color.white

    local function update()
        local txt = awful.util.escape(c.class or "Unknown")
        w:set_markup(string.format('<span color="%s">%s</span>', w._current_color, txt))
    end

    c:connect_signal("property::name", update)

    if is_highlighted then
        c:connect_signal("focus", function() w._current_color = beautiful.color.white; update() end)
        c:connect_signal("unfocus", function() w._current_color = beautiful.color.green_dark; update() end)
    end

    update()
    return w
end



-- Connect titlebar building signal
-----------------------------------------------------------------------------------------------------------------------
function titlebar:init()

    local style = {}

    -- titlebar setup for clients
    -- Add a titlebar if titlebars_enabled is set to true in the rules.
    client.connect_signal("request::titlebars", function(c)
        -- buttons for the titlebar
         local buttons = {
            awful.button({ }, 1, function()
                c:activate { context = "titlebar", action = "mouse_move"  }
            end),
            awful.button({ }, 3, function()
                c:activate { context = "titlebar", action = "mouse_resize"}
            end),
        }


        awful.titlebar(c):setup {
            {
                -- Left
                layout = wibox.layout.fixed.horizontal
            },
            title,
            {
                -- Right
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }

     
    end)
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return titlebar
