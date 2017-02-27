
	-- libraries
local awful = require( "awful" )
require( "awful.autofocus" )

local naughty = require( "naughty" )
local wibox = require( "wibox" )
local beautiful = require( "beautiful" )
local gears = require( "gears" )
local hotkeys_popup = require( "awful.hotkeys_popup" ).widget

	-- theming
beautiful.init( "~/.config/awesome/zenburn/theme.lua" )

function set_wallpaper( s )
	if beautiful.wallpaper then
		local wp = beautiful.wallpaper
		if type( wp ) == "function" then
			wp = wp( s )
		end
		gears.wallpaper.tiled( wp, s )
	end
end

	-- notifications
naughty.config.defaults.position = "top_right"
naughty.config.defaults.font = beautiful.font
naughty.config.defaults.fg = beautiful.fg_normal
naughty.config.defaults.bg = beautiful.bg_normal
naughty.config.defaults.border_width = beautiful.tooltip_border_width
naughty.config.defaults.border_color = beautiful.border_normal

naughty.config.presets.critical.fg = beautiful.fg_urgent
naughty.config.presets.critical.bg = beautiful.bg_normal

function notify_err( err, nid_repl )
	nid_repl = nid_repl or nil
	nid = naughty.notify( {
		preset=naughty.config.presets.critical,
		screen=mouse.screen,
		text=err,
		replaces_id=nid_repl
	} ).id
	return nid
end

function notify_msg ( title, msg, nid_repl )
	nid_repl = nid_repl or nil
	nid = naughty.notify( {
		preset=naughty.config.presets.normal, 
		screen=mouse.screen, 
		title=title,
		text=msg,
		replaces_id=nid_repl
	} ).id
	return nid
end

local nid_tags = nil
local nid_xrandr = nil
local nid_layout = nil

	-- variables
local app_prompt = {"dmenu_run -b -p \"run: \" -nb \"" .. beautiful.bg_systray .."\" -nf \"" .. beautiful.fg_normal .. "\" -sb \"" .. beautiful.bg_focus .. "\" -sf \"" .. beautiful.fg_focus .. "\" -fn \"Liberation Mono-9\"", ""}
local app_terminal = {"terminator", ""}
local app_filemanager = {"nautilus", ""}
local app_audiomanager = {"audacious", "Audacious"}
local app_webbrowser = {"firefox", "Firefox"}
local app_mailclient = {"sylpheed", "Sylpheed"}
local app_calc = {"galculator", "Galculator"}
local app_dictionary = {"dudenbib", "Dudenbib.bin"}
local app_pdf = {"qpdfview --unique", "qpdfview"}

	-- conky
conky_class = "conky"
conky_start = "conky"
conky_stop = "killall conky"

	-- helpers
function launch( cmd, classname )

		-- raise singleton
	if classname ~= "" then
		local matched = nil -- find class name match
		local clients = client.get()
		for _, c in pairs( clients ) do
			local m = true
			for k, v in pairs( {class=classname} ) do
				if c[k] ~= v then --and not c[k]:find( v ) then
					m = false
					break
				end
			end
			if m then
				matched = c
				break
			end
		end

		if matched then -- raise matching client
			awful.tag.viewonly( matched:tags()[1] )
			client.focus = matched
			matched:raise()
			 
			nid_tags = notify_msg( "desktop", awful.screen.focused().selected_tag.name, nid_tags )
			return
		end
	end

		-- spawn client
	awful.spawn( cmd )

end

function getclients( tag )
	clients = {}

	for _, c in pairs( tag:clients() ) do
		if c.class ~= conky_class and not c.modal then
			clients[#clients+1] = c
		end
	end

	return clients
end

	-- startup
if awesome.startup_errors then
	notify_err( awesome.startup_errors )
end	

do
	local in_error = false
	awesome.connect_signal( "debug::error",
		function ( err )
			if in_error then
				return
			end

			in_error = true
			notify_err( err )
			in_error = false
		end
	)
end

awful.spawn( conky_start )

	-- tags, layouts
local layouts = {
    awful.layout.suit.tile.left, -- default
    awful.layout.suit.floating
}

for i = 1, screen.count() do
	awful.screen.connect_for_each_screen(
		function ( s )
    		set_wallpaper( s )
			awful.tag( {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"}, s, layouts[1] )
		end
	)
end

	-- keyboard layout
local xkb_cur = 1;

function xkb_toggle()
	xkb_cur = 1-xkb_cur; -- toggle state
	if xkb_cur == 0 then
		awful.spawn.with_shell( "setxkbmap -variant \"\"" )
	else
		awful.spawn.with_shell( "setxkbmap -variant nodeadkeys" )
	end
end

	-- display, TODO: avoid hard-coding!
local xrandr_cur = 1
local xrandr_timer = nil
local xrandr_mode = "`xrandr --query | awk '/^ *[0-9]*x[0-9]*/{ print $1 }' | sort -n | uniq -d | tail -1`"
local xrandr_state = {{}}
xrandr_state[1] = {"intern only", "xrandr --output VIRTUAL1 --off --output LVDS1 --mode 1366x768 --pos 0x0 --rotate normal --output VGA1 --off"}
xrandr_state[2] = {"extern only", xrandr_state[1][2] .. "; xrandr --output LVDS1 --off --output VGA1 --auto --pos 0x0 --rotate normal"}
xrandr_state[3] = {"cloned min", xrandr_state[1][2] .. "; xrandr --output LVDS1 --mode " .. xrandr_mode .. " --pos 0x0 --rotate normal --output VGA1 --mode " .. xrandr_mode .. " --pos 0x0 --rotate normal"}
xrandr_state[4] = {"cloned max", xrandr_state[1][2] .. "; xrandr --output VGA1 --auto --pos 0x0 --rotate normal"}

function xrandr_switch()
	if xrandr_timer then -- stop timer
		xrandr_timer:stop()
		xrandr_timer = nil
	end

	xrandr_cur = xrandr_cur+1 -- switch state
	if xrandr_cur > #xrandr_state then
		xrandr_cur = 1
	end

	nid_xrandr = notify_msg( "xrandr", xrandr_state[xrandr_cur][1], nid_xrandr )

	xrandr_timer = timer( {timeout=5} ) -- start timer
	xrandr_timer:connect_signal( "timeout",
		function()
			xrandr_timer:stop()
			xrandr_timer = nil

			awful.spawn.with_shell( xrandr_state[xrandr_cur][2] )

			awful.spawn( conky_stop )
			awful.spawn( conky_start )

			if beautiful.wallpaper then
				for i = 1, screen.count() do
					gears.wallpaper.tiled( beautiful.wallpaper, i )
				end
			end
		end
	)
	xrandr_timer:start()
end

function screen_shot()
	--[[awful.spawn.with_shell( "maim -s -c 1,0,0,0.6 -p 10 ~/tmp/$(date +%Y%m%d-%H%M%S).png" )]]
	awful.spawn.with_shell( "maim -i $(xdotool getactivewindow) ~/tmp/$(date +%Y%m%d-%H%M%S).png" )
end

	-- mouse bindings
local buttons_global = awful.util.table.join(
)
local buttons_client = awful.util.table.join(
	awful.button( {}, 1,
		function ( c )
			client.focus = c
			c:raise()
		end
	)
)

root.buttons( buttons_global )

	-- global keys
local keys_global = awful.util.table.join(

		-- general
	awful.key( {"Mod4", "Shift"}, "h", hotkeys_popup.show_help ),

	awful.key( {"Mod4", "Control", "Shift"}, "r",
		function ()
			awful.spawn( conky_stop )
			awesome.restart()
		end,
		{description="reset", group="general"}
	),
	awful.key( {"Mod4", "Control", "Shift"}, "q",
		function ()
			awful.spawn( conky_stop )
			awesome.quit()
		end,
		{description="quit", group="general"}
	),

		-- launchers
	awful.key( {"Mod4", "Shift"}, "Return",
		function ()
			launch( app_prompt[1], app_prompt[2] )
		end,
		{description="prompt", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "t",
		function ()
			launch( app_terminal[1], app_terminal[2] )
		end,
		{description="terminal", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "f",
		function ()
			launch( app_filemanager[1], app_filemanager[2] )
		end,
		{description="file manager", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "w",
		function ()
			launch( app_webbrowser[1], app_webbrowser[2] )
		end,
		{description="web browser", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "m",
		function ()
			launch( app_mailclient[1], app_mailclient[2] )
		end,
		{description="mail client", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "c",
		function ()
			launch( app_calc[1], app_calc[2] )
		end,
		{description="calculator", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "a",
		function ()
			launch( app_audiomanager[1], app_audiomanager[2] )
		end,
		{description="audio manager", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "d",
		function ()
			launch( app_dictionary[1], app_dictionary[2] )
		end,
		{description="dictionary", group="launchers"}
	),
	awful.key( {"Mod4", "Shift"}, "q",
		function ()
			launch( app_pdf[1], app_pdf[2] )
		end,
		{description="pdf viewer", group="launchers"}
	),

		-- tags
	awful.key( {"Mod4"}, "Left", 
		function ()
			awful.tag.viewidx( -1 )
			nid_tags = notify_msg( "desktop", awful.screen.focused().selected_tag.name, nid_tags )
		end,
		{description="show previous", group="tags"}
	), 
	awful.key( {"Mod4"}, "Right", 
		function ()
			awful.tag.viewidx( 1 )
			nid_tags = notify_msg( "desktop", awful.screen.focused().selected_tag.name, nid_tags )
		end,
		{description="show next", group="tags"}
	), 

		-- layout
	awful.key( {"Mod4"}, "space",
		function ()
			awful.layout.inc( layouts, 1 )
			nid_layout = notify_msg( "layout", awful.layout.getname(), nid_layout )
		end,
		{description="toggle tile/float", group="layout"}
	),

		-- keyboard
	awful.key( {"Mod4"}, "l", xkb_toggle ),

		-- display
	awful.key( {}, "XF86Display", xrandr_switch ),
	awful.key( {"Mod4"}, "p", screen_shot ),

		-- conky
	awful.key( {"Mod4"}, "c",
		function ()
			local clients = client.get()
			local i = 1
			while clients[i] do
				if clients[i].class == conky_class then
					clients[i].ontop = not clients[i].ontop
				end
				i = i+1
			end
		end
	),

		-- application switcher
	awful.key( {"Mod4"}, "Tab",
		function ()
			awful.client.focus.byidx( -1 )
			if client.focus then
				client.focus:raise()
			end
		end
	)

)

root.keys( keys_global )

	-- client keys
local keys_client = awful.util.table.join(

		-- layout
	awful.key( {"Mod4"}, "Return",
		function ( c )
			awful.client.setmaster( c )
		end
	),

	awful.key( {"Mod4"}, "Up",
		function ( c )
			if c == awful.client.getmaster() then
				awful.tag.incmwfact( 0.05 )
			else
				if #awful.client.tiled() == 2 then
					awful.tag.incmwfact( -0.05 )
				else
					awful.client.incwfact( 0.05, c )
				end
			end
		end
	),
	awful.key( {"Mod4"}, "Down",
		function ( c )
			if c == awful.client.getmaster() then
				awful.tag.incmwfact( -0.05 )
			else
				if #awful.client.tiled() == 2 then
					awful.tag.incmwfact( 0.05 )
				else
					awful.client.incwfact( -0.05, c )
				end
			end
		end
	),

	awful.key( {"Mod4", "Shift"}, "Left",
		function( c )
			local tags = awful.screen.focused().tags
			local cur = awful.screen.focused().selected_tag.index
			if cur == 1 then
				c:move_to_tag( tags[#tags] )
			else
				c:move_to_tag( tags[cur-1] )
			end
			awful.tag.viewidx( -1 )
			nid_tags = notify_msg( "desktop", awful.screen.focused().selected_tag.name, nid_tags )
		end
	),
	awful.key( {"Mod4", "Shift"}, "Right",
		function( c )
			local tags = awful.screen.focused().tags
			local cur = awful.screen.focused().selected_tag.index
			if cur == #tags then
				c:move_to_tag( tags[1] )
			else
				c:move_to_tag( tags[cur+1] )
			end
			awful.tag.viewidx( 1 )
			nid_tags = notify_msg( "desktop", awful.screen.focused().selected_tag.name, nid_tags )
		end
	),

	awful.key( {"Mod4"}, "t", awful.titlebar.toggle	)

)

	-- rules
awful.rules.rules = {

		-- general
	{rule = {}, properties = {
		border_width = beautiful.border_width,
		border_color = beautiful.border_normal,
		focus = awful.client.focus.filter, 
		raise = true, 
		maximized_vertical = false, 
		maximized_horizontal = false, 
		keys = keys_client, 
		buttons = buttons_client,
		screen = awful.screen.preferred,
		placement = awful.placement.no_overlap + awful.placement.no_offscreen
	}},

		-- qiv
	{rule = {name = "qiv"}, properties = {
		floating = true
	}},

		-- mplayer
	--{rule = {name = "MPlayer"}, properties = {
		--floating = true
	--}},

		-- calculator
	{rule = {class = app_calc[2]}, properties = {
		floating = true,
		ontop = true,
		size_hints = {"program_position", "program_size"}
	}},

		-- conky
	{rule = {class = conky_class}, properties = {
		border_width = 0,
		floating = true,
		sticky = true,
		ontop = false,
		focusable = false,
		size_hints = {"program_position", "program_size"}
	}},

		-- matlab r2015b offscreen figures
	{rule = {name = "HG_Peer_OffScreenWindow"}, properties = {
		floating = true,
		ontop = false,
		focusable = false
	}},
	
}

	-- signals
client.connect_signal( "manage",
	function ( c, startup )

			-- create titlebar
		if c.class ~= conky_class then

				-- left (close)
			local bar_left = wibox.layout.fixed.horizontal()
			bar_left:add( awful.titlebar.widget.closebutton( c ) )

				-- right (icon)
			local bar_right = wibox.layout.fixed.horizontal()
			bar_right:add( awful.titlebar.widget.iconwidget( c ) )

				-- middle (title)
			local bar_middle = wibox.layout.flex.horizontal()
			local widget_title = awful.titlebar.widget.titlewidget( c )
			widget_title:set_align( "center" )
			widget_title:set_font( beautiful.font )
			bar_middle:add( widget_title )

			local buttons = awful.util.table.join(
				awful.button( {}, 1,
					function ()
						awful.mouse.client.move( c )
					end
				),
				awful.button( {}, 3,
					function ()
						awful.mouse.client.resize( c )
					end
				)
			)
			bar_middle:buttons( buttons )

				-- create bar
			local bar = wibox.layout.align.horizontal()
			bar:set_left( bar_left )
			bar:set_right( bar_right )
			bar:set_middle( bar_middle )

			awful.titlebar( c ):set_widget( bar )

			--[[if #getclients( c:tags()[1] ) == 1 and not c.modal then
			   [    awful.titlebar.hide( c )
			   [end]]
			if not c.modal and c.class ~= app_calc[2] then
				awful.titlebar.hide( c )
			end

		end

			-- adjust modal border
		if c.modal or c.class == app_calc[2] then
			c.border_width = 0; -- beautiful.tooltip_border_width;
		end

	end
)

client.connect_signal( "focus",
	function ( c )
		c.border_color = beautiful.border_focus
	end
)
client.connect_signal( "unfocus",
	function ( c )
		c.border_color = beautiful.border_normal
	end
)

--[[client.connect_signal( "tagged",
   [    function ( c, t )
   [        clients = getclients( t )
   [        if #clients == 1 then -- updated title bar visibility
   [            awful.titlebar.hide( clients[1] )
   [        elseif #clients > 1 then
   [            for _, c in pairs( clients ) do
   [                awful.titlebar.show( c )
   [            end
   [        end
   [    end
   [)
   [client.connect_signal( "untagged",
   [    function ( c, t )
   [        clients = getclients( t )
   [        if #clients == 1 then -- update title bar visibility
   [            awful.titlebar.hide( clients[1] )
   [        elseif #clients > 1 then
   [            for _, c in pairs( clients ) do
   [                awful.titlebar.show( c )
   [            end
   [        elseif #client == 0 then -- reset tiling
   [            awful.tag.setproperty( awful.screen.focused().selected_tag, "mwfact", 0.5 );
   [        end
   [    end
   [)]]

