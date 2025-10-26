return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
     cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
    lazy = false
  },

  {
    "mbbill/undotree",
    config = function ()
      vim.keymap.set("n", "<leader>u", "UndotreeToggle")
    end,
    lazy = false
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc", "typescript", "javascript",
       "html", "css", "go", "cpp", "glsl", "go", "php", "cpp"
  		},
      sync_install = true,
      auto_install = true,
  	},
  },

  -- Ai autocomplete tool
  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function ()
  --     require("supermaven-nvim").setup({})
  --   end,
  --   lazy = false
  -- }
}
