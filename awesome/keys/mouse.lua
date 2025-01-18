local gears = require("gears")
local awful = require("awful")
local menu = require("widgets.menu")

local mouseKeys = gears.table.join(awful.button({}, 3, function()
	menu[1]:toggle()
end))

return mouseKeys
