-----------------------------------------------------------------------------------------------------------------------
--                                                  Environment config                                               --
-----------------------------------------------------------------------------------------------------------------------

local awful         = require("awful")
local beautiful     = require("beautiful")
local gears         = require("gears")
local wibox         = require("wibox")
local util          = require("utilities")
local unpack        = unpack or table.unpack

-- Initialize tables and variables for module
-----------------------------------------------------------------------------------------------------------------------
local env = {}


function env:init(args)
    --init vars
    args = args or {}
    -- env vars
    self.term       = "alacritty" or "st" or "xterm"
    self.mod        = args.mod or "Mod4"
    self.alt        = "Mod1"
    self.home       = os.getenv("HOME")
    self.editor_cmd = os.getenv("EDITOR") or "vim"
    self.editor_gui = "code"
    self.themedir   = self.home .. "/.config/awesome/"
    self.taglist    = {" MAIN ", " EDIT ", " WEB ", " FILES ", " OTHERS "}
    -- theme setup
	  beautiful.init(env.themedir .. "theme.lua")
end


-- Wallpaper setup
--------------------------------------------------------------------------------
env.set_wallpaper = function(s)
	if beautiful.wallpaper then
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end


env.wrapper = function (widget,name,buttons)
  local margin = beautiful.wrapper[name] or { 0, 0, 0, 0}

  if buttons then
		widget:buttons(buttons)
  end
  
  return wibox.container.margin(widget, unpack(margin))
end


-- End
-----------------------------------------------------------------------------------------------------------------------
return setmetatable(env, { __call = function(_, ...) return new(...) end })
