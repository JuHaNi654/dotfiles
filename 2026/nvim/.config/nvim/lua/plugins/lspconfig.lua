return {
  "neovim/nvim-lspconfig",
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
