-- First read our docs (completely) then check the example_config repo

local M = {}

M.mappings = require "custom.mappings"

M.ui = {
  theme = "onedark",
}

M.plugins = {
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["stevearc/aerial.nvim"] = {
    after = "nvim-lspconfig",
    config = function ()
      require "custom.plugins.aerial"
    end,
  },

  ["simrat39/rust-tools.nvim"] = {
    after = "nvim-lspconfig",
    config = function ()
      require "custom.plugins.rtools"
    end,
  },

  ["anuvyklack/hydra.nvim"] = {},

  ["iamcco/markdown-preview.nvim"] = {
    run = function ()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Enable some default plugins
  ["goolord/alpha-nvim"] = {
    after = "base46",
    disable = false,
    config = function()
      require "plugins.configs.alpha"
    end,
  },

  ["folke/which-key.nvim"] = {
    disable = false,
    module = "which-key",
    keys = { "<leader>", '"', "'", "`" },
    config = function()
      require "plugins.configs.whichkey"
    end,
    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },
}

return M
