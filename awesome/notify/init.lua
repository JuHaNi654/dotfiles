local naughty = require("naughty")

local function notify_error(msg)
  naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, an error happened!",
		text = msg,
    font = "Monospace 12",
    fg = "#ffffff",
    bg = "#000000",
  })
end

return {
	error = notify_error,
}
