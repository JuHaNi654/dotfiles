local gears = require("gears")
local awful = require("awful")

local modKey = require("keys.mod").modKey

-- Mouse bindings
local clientButtons = gears.table.join(
	awful.button({}, 1, function(c)
	  if c then
      c:emit_signal("request::activate", "mouse_click", { raise = true })
    end
  end),
	awful.button({ modKey }, 1, function(c)
	  if c then
      c:emit_signal("request::activate", "mouse_click", { raise = true })
		  awful.mouse.client.move(c)
    end
	end),
	awful.button({ modKey }, 3, function(c)
	  if c then
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.resize(c)
    end
	end)
)

return clientButtons
