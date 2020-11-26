-- Library
--------------------------------------------------------
local awful         =   require("awful")
local gears         =   require("gears")
local wibox         =   require("wibox")
local util        = require("utilities")


local taglist      = { mt = {} }


--  Tasklis button
--------------------------------------------------------
local taglist_buttons = awful.util.table.join(
	awful.button({         }, 1, function(t) t:view_only() end),
	awful.button({         }, 2, awful.tag.viewtoggle)
)

-- taglist
--------------------------------------------------------
function taglist.new(s)
    local widget = awful.widget.taglist{
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style   = {
            shape = util.shape.rectangle.first_style
        },
    }
    return widget
end

function taglist.mt:__call(...)
	return taglist.new(...)
end

-- return
--------------------------------------------------------
return setmetatable(taglist, taglist.mt)