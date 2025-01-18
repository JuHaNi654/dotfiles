local terminal = require("apps.terminal")
local awful = require("awful")
require("awful.autofocus")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- Create a launcher widget and a main menu
local layout = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", terminal.terminal .. " -e man awesome" },
	{ "edit config", terminal.editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

local menu_awesome = { "awesome", layout, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }
local menu = {}

if has_fdo then
	menu = freedesktop.menu.build({
		before = { menu_awesome },
		after = { menu_terminal },
	})
else
	menu = awful.menu({
		items = {
			menu_awesome,
			{ "Debian", debian.menu.Debian_menu.Debian },
			menu_terminal,
		},
	})
end

local launcher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = menu,
})

-- Menubar configuration
menubar.utils.terminal = terminal[1]

return {
	menu,
	launcher,
}
