local beautiful = require("beautiful")
local gears = require("gears")

local path = os.getenv("HOME") .. "/.config/awesome/images"
local command = "ls -1 " .. path
local handle = io.popen(command)

local files = {}
if handle then
  for line in handle:lines() do
      table.insert(files, line)
  end
  handle:close()
end

math.randomseed(os.time())
local f = math.random(1, #files)

beautiful.get().wallpaper = path .. "/synthwave_1.jpg"

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

return set_wallpaper
