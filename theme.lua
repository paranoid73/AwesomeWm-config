local themes_path   = os.getenv("HOME") .. "/.config/awesome/resources"
local theme 		= {}

theme.wallpaper     = themes_path .. "/wallpaper/OR4EJM0.jpg"

theme.color 		= {
	bg 		  	= "#252e25",
	black     	= "#161616",
	black_gray	= "#363333",
	dark 	  	= "",
	blue	  	= "#0EC3B8",
	gray      	= "#5a5b5d",
	yellow	  	= "#C0B738",
	red       	= "#D60B17",
	green	  	= "#384d30",
	green_dark	= "#091113",
	green_light	= "#C3FF10",
	orange		= "#f68633",
	white	  	= "#FFFFFF"
}
-- wibar width
theme.wibar   = {
		top    = 40,
		bottom = 35
}

theme.useless_gap                   = 8
theme.border_width					= 0
theme.font          				= "Roboto condensed 10"
theme.fg_normal						= theme.color.white

theme.bg_normal 					= theme.color.bg
theme.border_normal					= theme.color.bg
theme.border_focus					= theme.color.green
theme.border_marked                 = theme.color.bg

-- wibar
theme.wibar_bg 						= theme.color.bg
theme.wibar_fg 						= theme.color.white


-- menubar\
theme.menubar_fg_normal 			= theme.color.white
theme.menubar_bg_normal 			= theme.color.bg
theme.menubar_border_width 			= 0
theme.menubar_fg_focus 				= "#FFFFFF"
theme.menubar_bg_focus 				= theme.color.green

-- taglist
theme.taglist_font					= "Roboto Bold 9"
theme.taglist_bg_urgent				= theme.color.red
theme.taglist_fg_focus 				= theme.color.white
theme.taglist_bg_focus 				= theme.color.green
theme.taglist_spacing				= 6

-- tasklist
theme.tasklist_font					= "Roboto Condensed Bold 9"
theme.tasklist_disable_icon 		= true
theme.tasklist_plain_task_name 		= true
theme.tasklist_fg_normal			= theme.color.white
theme.tasklist_fg_focus				= theme.color.white
theme.tasklist_bg_normal			= theme.color.bg
theme.tasklist_bg_focus				= theme.color.green


-- systray
theme.bg_systray 					= theme.color.bg

-- hotkey
theme.hotkeys_label_bg				= theme.color.white
theme.hotkeys_bg 					= theme.color.bg
theme.hotkeys_fg 					= theme.color.text
theme.hotkeys_border_width 			= 0
theme.hotkeys_group_margin 			= 20

-- notification
theme.notification_font				=  "Roboto Condensed Bold 8"
theme.notification_bg				=  theme.color.bg
theme.notification_fg				=  theme.color.white
theme.notification_border_width		=  5
theme.notification_border_color		=  theme.color.green
theme.notification_icon_size 		=  80
theme.notification_max_width        =  300
theme.notification_max_height       =  70
theme.notification_margin			=  10
theme.notification_padding 			=  10


-- titlebar
theme.titlebar_bg 					= theme.color.bg

--Layout
theme.layout_max  					= themes_path.."/icons/layouts/max.svg"
theme.layout_floating  				= themes_path.."/icons/layouts/floating.svg"
theme.layout_magnifier				= themes_path.."/icons/layouts/magnifier.svg"

theme.layout_tile	  				= themes_path.."/icons/layouts/tile.svg"
theme.layout_tileleft 				= themes_path.."/icons/layouts/tileleft.svg"
theme.layout_tiletop  				= themes_path.."/icons/layouts/tiletop.svg"
theme.layout_tilebottom  			= themes_path.."/icons/layouts/tilebottom.svg"


theme.layout_fairv	  				= themes_path.."/icons/layouts/fair.svg"
theme.layout_fairh	  				= themes_path.."/icons/layouts/fair.svg"
theme.layout_spiral  				= themes_path.."/icons/layouts/spiral.svg"

theme.layout_cornernw	  			= themes_path.."/icons/layouts/cornernw.svg"
theme.layout_dwindle 				= themes_path.."/icons/layouts/cornernw.svg"

-- fullscreen
theme.fullscreen_hide_border 		= true

--  icon 
theme.icons							=	{
	alert 							= themes_path .. "/icons/others/yellow.png",
	show_apps						= themes_path .. "/icons/apps.svg",
	arrow_left						= themes_path .. "/icons/others/arrow_left.svg"
}


-- audio
theme.audio 						= {
	on								= themes_path .. "/icons/audio/on.svg",
	mute							= themes_path .. "/icons/audio/mute.svg"
}

-- exit screen
theme.exit_screen					= {
	icon 	= themes_path .. "/icons/others/yellow.png",
	title 	= "Roboto Condensed Bold 30",
	text 	= "Roboto Condensed Bold 20",
}


-- individual margins for panel widgets
--------------------------------------------------------------------------------
theme.wrapper = {
	layoutbox   = { 12, 10, 6, 6 },
	textclock   = { 10, 10, 0, 0 },
	volume      = { 0, 0, 2, 5 },
	backlight   = { 10, 10, 5, 5 },
	network     = { 10, 10, 5, 5 },
	battery     = { 8, 10, 7, 7 },
	systray     = { 0, 1, 8, 8 },
	taglist		= { 8 , 8 , 8 , 8},
	tasklist    = { 10, 8, 8, 8 },
	profile     = { 4, 8, 5, 5 }
}

return theme

