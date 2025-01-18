local terminal = "x-terminal-emulator"
local editor = os.getenv("EDITOR") or "editor"
local editor_cmd = terminal .. " -e " .. editor

return {
  terminal = terminal,
  editor = editor,
  editor_cmd = editor_cmd
}
