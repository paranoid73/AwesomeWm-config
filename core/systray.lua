-- Grab environment
-----------------------------------------------------------------------------------------------------------------------
local setmetatable = setmetatable
local table = table

local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")

local util = require("utilities")
local dotcount = util.progressbar.dot

local placement = {}
local direction = { x = "width", y = "height" }


-- Functions
-----------------------------------------------------------------------------------------------------------------------
function placement.add_gap(geometry, gap)
	return {
		x = geometry.x + gap,
		y = geometry.y + gap,
		width = geometry.width - 2 * gap,
		height = geometry.height - 2 * gap
	}
end

function no_offscreen(object, gap, area)
	local geometry = object:geometry()
	local border = object.border_width

	local screen_idx = object.screen or awful.screen.getbycoord(geometry.x, geometry.y)
	area = area or screen[screen_idx].workarea
	if gap then area = placement.add_gap(area, gap) end

	for coord, dim in pairs(direction) do
		if geometry[coord] + geometry[dim] + 2 * border > area[coord] + area[dim] then
			geometry[coord] = area[coord] + area[dim] - geometry[dim] - 2*border
		elseif geometry[coord] < area[coord] then
			geometry[coord] = area[coord]
		end
	end

	object:geometry(geometry)
end

-- Initialize tables and wibox
-----------------------------------------------------------------------------------------------------------------------
local minitray = { widgets = {}, mt = {} }

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		dotcount     = {},
		geometry     = { height = 40 },
		set_position = nil,
		screen_gap   = 0,
		border_width = 2,
		color        = { wibox = "#202020", border = "#575757" },
		shape        = nil
	}
	return style
end

-- Initialize minitray floating window
-----------------------------------------------------------------------------------------------------------------------
function minitray:init(style)

	-- Create wibox for tray
	--------------------------------------------------------------------------------
	local wargs = {
		ontop        = true,
		bg           = style.color.wibox,
		border_width = style.border_width,
		border_color = style.color.border,
		shape        = style.shape
	}

	self.wibox = wibox(wargs)
	self.wibox:geometry(style.geometry)

	self.geometry = style.geometry
	self.screen_gap = style.screen_gap
	self.set_position = style.set_position


	-- Set tray
	--------------------------------------------------------------------------------
	local l = wibox.layout.align.horizontal()
	self.tray = wibox.widget.systray()
	l:set_middle(self.tray)
	self.wibox:set_widget(l)

	-- update geometry if tray icons change
	self.tray:connect_signal('widget::redraw_needed', function()
		self:update_geometry()
	end)
end

-- Show/hide functions for wibox
-----------------------------------------------------------------------------------------------------------------------

-- Update Geometry
--------------------------------------------------------------------------------
function minitray:update_geometry()

	-- Set wibox size and position
	------------------------------------------------------------
	local items = awesome.systray()
	if items == 0 then items = 1 end

	self.wibox:geometry({ width = self.geometry.width or self.geometry.height * items })

	if self.set_position then
		self.set_position(self.wibox)
	else
		awful.placement.under_mouse(self.wibox)
	end

	no_offscreen(self.wibox, self.screen_gap, mouse.screen.workarea)
end

-- Show
--------------------------------------------------------------------------------
function minitray:show()
	self:update_geometry()
	self.wibox.visible = true
end

-- Hide
--------------------------------------------------------------------------------
function minitray:hide()
	self.wibox.visible = false
end

-- Toggle
--------------------------------------------------------------------------------
function minitray:toggle()
	if self.wibox.visible then
		self:hide()
	else
		self:show()
	end
end

-- Create a new tray widget
-- @param args.timeout Update interval
-- @param style Settings for dotcount widget
-----------------------------------------------------------------------------------------------------------------------
function minitray.new(_, style)

	-- Initialize vars
	--------------------------------------------------------------------------------
--	args = args or {} -- usesless now, leave it be for backward compatibility and future cases
	style = default_style()

	-- Initialize minitray window
	--------------------------------------------------------------------------------
	if not minitray.wibox then
		minitray:init(style)
	end

	-- Create tray widget
	--------------------------------------------------------------------------------
	local widg = dotcount(style.dotcount)
	table.insert(minitray.widgets, widg)


	-- Set update timer
	--------------------------------------------------------------------------------
	function widg:update()
		local appcount = awesome.systray()
		self:set_num(appcount)
	end

	minitray.tray:connect_signal('widget::redraw_needed', function() widg:update() end)

	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call minitray module as function
-----------------------------------------------------------------------------------------------------------------------
function minitray.mt:__call(...)
	return minitray.new(...)
end

return setmetatable(minitray, minitray.mt)
