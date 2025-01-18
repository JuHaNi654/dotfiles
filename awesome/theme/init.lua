local beautiful = require("beautiful")
local gears = require('gears')

-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- Custom configs
beautiful.useless_gap=10
beautiful.border_width=0
