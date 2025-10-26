require "nvchad.mappings"

local map = vim.keymap.set

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
map("n", "<leader>u", function() vim.cmd("UndotreeToggle") end)
