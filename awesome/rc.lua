-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local awful = require("awful")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
local notify_error = require("notify").error

-- Startup errors
if awesome.startup_errors then
	notify_error(awesome.startup_errors)
end

do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then
			return
		end
		in_error = true
		notify_error(tostring(err))
		in_error = false
	end)
end
-- }}}

-- Theme
require("theme")

-- Run external apps 
require('apps')

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	awful.layout.suit.corner.nw,
}

-- Screen
require("window.main")

-- Mouse
root.buttons(require("keys.mouse"))

-- Set keys
root.keys(require("keys.global"))

-- Rules
require("rules")

-- Signals
require("signals")
