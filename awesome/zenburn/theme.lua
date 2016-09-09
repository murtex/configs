-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

	-- theme directory
local dir_theme = "~/.config/awesome/zenburn/"

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
theme = {}
theme.wallpaper = dir_theme .. "background.png"
-- }}}

-- {{{ Styles
theme.font      = "sans-serif 8"

-- {{{ Colors
theme.bg_normal  = "#3F3F3F"
theme.fg_normal  = "#F0DFAF"
theme.bg_focus   = "#4F4F4F"
theme.fg_focus   = "#F0DFAF"
theme.bg_urgent  = "#6F6F6F"
theme.fg_urgent  = "#CC9393"
theme.bg_systray = "#1E2320"
-- }}}

-- {{{ Borders
theme.border_width  = 4
theme.tooltip_border_width = 1
theme.border_normal  = theme.bg_systray
theme.border_focus = theme.bg_systray
theme.border_marked = theme.bg_systray
-- }}}

-- {{{ Titlebars
--[[theme.titlebar_bg_normal = theme.bg_focus
   [theme.titlebar_bg_focus  = "#6f6f6f"
   [theme.titlebar_bg_focus  = theme.bg_normal]]
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = 15
theme.menu_width  = 100
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = dir_theme .. "taglist/squarefz.png"
theme.taglist_squares_unsel = dir_theme .. "taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = dir_theme .. "awesome-icon.png"
theme.menu_submenu_icon      = dir_theme .. "default/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = dir_theme .. "layouts/tile.png"
theme.layout_tileleft   = dir_theme .. "layouts/tileleft.png"
theme.layout_tilebottom = dir_theme .. "layouts/tilebottom.png"
theme.layout_tiletop    = dir_theme .. "layouts/tiletop.png"
theme.layout_fairv      = dir_theme .. "layouts/fairv.png"
theme.layout_fairh      = dir_theme .. "layouts/fairh.png"
theme.layout_spiral     = dir_theme .. "layouts/spiral.png"
theme.layout_dwindle    = dir_theme .. "layouts/dwindle.png"
theme.layout_max        = dir_theme .. "layouts/max.png"
theme.layout_fullscreen = dir_theme .. "layouts/fullscreen.png"
theme.layout_magnifier  = dir_theme .. "layouts/magnifier.png"
theme.layout_floating   = dir_theme .. "layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = dir_theme .. "titlebar/close_focus.png"
theme.titlebar_close_button_normal = dir_theme .. "titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = dir_theme .. "titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = dir_theme .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = dir_theme .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = dir_theme .. "titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = dir_theme .. "titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = dir_theme .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = dir_theme .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = dir_theme .. "titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = dir_theme .. "titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = dir_theme .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = dir_theme .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = dir_theme .. "titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = dir_theme .. "titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = dir_theme .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = dir_theme .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = dir_theme .. "titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
