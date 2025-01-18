local filesystem = require("gears.filesystem")
local awful = require("awful")

local apps = {
	"polybar",
	"picom --config " .. filesystem.get_configuration_dir() .. "/picom.conf",
}

-- TODO: fix language setup on start
local cmds = {
	"setxkbmap fi",
}

local function run_once(cmd)
	local findme = cmd
	local firstspace = cmd:find(" ")
	if firstspace then
		findme = cmd:sub(0, firstspace - 1)
	end
	awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

for _, app in ipairs(apps) do
	run_once(app)
end

for _, cmd in ipairs(cmds) do
	os.execute(cmd)
end

return {
	run_once = run_once,
}
