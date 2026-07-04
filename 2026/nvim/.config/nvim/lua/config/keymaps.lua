local map = vim.keymap.set

-- Doesnt take replaced text to the copy buffer
map("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- Vim - tmux
map("n", "<c-h>", function()
  vim.cmd("TmuxNavigateLeft")
end)

map("n", "<c-j>", function()
  vim.cmd("TmuxNavigateDown")
end)

map("n", "<c-k>", function()
  vim.cmd("TmuxNavigateUp")
end)

map("n", "<c-l>", function()
  vim.cmd("TmuxNavigateRight")
end)

-- Undotree
map("n", "<leader>u", function()
  vim.cmd("UndotreeToggle")
end)
