return {
  "neovim/nvim-lspconfig",
  init = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufname = vim.api.nvim_buf_get_name(args.buf)
        if bufname:match("^fugitive://") or bufname:match("^gitsigns://") then
          vim.schedule(function()
            vim.lsp.buf_detach_client(args.buf, args.data.client_id)
          end)
        end
      end,
    })
  end,
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      cssls = {},
      html = {},
      tailwindcss = {},
      ts_ls = {},
      gopls = {},
      lua_ls = {},
      qmlls = {
        cmd = { "qmlls6" },
      },
    },
  },
}
