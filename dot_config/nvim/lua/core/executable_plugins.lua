local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({function()
    -- Packer
    use "wbthomason/packer.nvim"

    use "nvim-lua/popup.nvim"

    use "MunifTanjim/nui.nvim"

    use "lewis6991/impatient.nvim"

    use {
        "nvim-lua/plenary.nvim",
        module = "plenary"
    }

    -- Colorscheme
    use "EdenEast/nightfox.nvim"
    use "glepnir/zephyr-nvim"
    use "olimorris/onedarkpro.nvim"
    use "navarasu/onedark.nvim"
    
    use  {
        "kyazdani42/nvim-web-devicons",
        event = "VimEnter",
        config = function() require "configs.icons" end,
    }

    use {
        "goolord/alpha-nvim",
        config = function () require "configs.alpha" end,
    }

    -- Notification Enhancer
    use {
        "rcarriga/nvim-notify",
        event = "VimEnter",
        config = function() require "configs.notify" end,
    }

    -- Neovim UI Enhancer
    use {
        "stevearc/dressing.nvim",
        event = "VimEnter",
        config = function() require "configs.dressing" end,
    }

    -- Cursorhold fix
    use {
        "antoinemadec/FixCursorHold.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function() vim.g.cursorhold_updatetime = 100 end,
    }

    -- Smarter Splits
    use {
        "mrjones2014/smart-splits.nvim",
        module = "smart-splits",
        config = function() require "configs.smart-splits" end,
    }

    -- which key
    use {
        "folke/which-key.nvim",
        module = "which-key",
        config = function() require "configs.which-key" end,
    }

    -- Bufferline
    -- use {
    --     "romgrk/barbar.nvim",
    --     after = "nvim-web-devicons",
    --     config = function() require "configs.bar" end,
    -- }

    -- Tabby
    use {
        "nanozuki/tabby.nvim",
        after = "nvim-web-devicons",
        config = function() require "configs.tabby" end,
    }

    -- Better buffer closing
    use {
        "famiu/bufdelete.nvim",
        cmd = { "Bdelete", "Bwipeout" }
    }

    -- File explorer
    -- use {
    --     "nvim-neo-tree/neo-tree.nvim", 
    --     branch = "v2.x",
    --     module = "neo-tree",
    --     cmd = "Neotree",
    --     requires = { { "MunifTanjim/nui.nvim", module = "nui" } },
    --     setup = function() vim.g.neo_tree_remove_legacy_commands = true end,
    --     config = function() require "configs.neo-tree" end,
    -- }

    -- Nvim tree
    use {
        "kyazdani42/nvim-tree.lua",
        config = function() require "configs.nvim-tree" end,
    }

    -- Built-in LSP
    use {
        "neovim/nvim-lspconfig",
        event = "VimEnter"
    }

    -- LSP manager
    use {
        "williamboman/nvim-lsp-installer",
        after = "nvim-lspconfig",
        config = function()
            require "configs.nvim-lsp-installer"
            require "configs.lsp"
        end,
    }

    -- LSP symbols
    use {
        "stevearc/aerial.nvim",
        module = "aerial",
        cmd = { "AerialToggle", "AerialOpen", "AerialInfo" },
        config = function() require "configs.aerial" end,
    }

    -- Formatting and linting
    use {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufRead", "BufNewFile" },
        config = function() require "configs.null-ls" end,
    }

    -- Statusline
    use {
        "feline-nvim/feline.nvim",
        after = "nvim-web-devicons",
        config = function() require "configs.feline" end,
    }

    -- Syntax highlighting
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        event = { "BufRead", "BufNewFile" },
        cmd = {
            "TSInstall",
            "TSInstallInfo",
            "TSInstallSync",
            "TSUninstall",
            "TSUpdate",
            "TSUpdateSync",
            "TSDisableAll",
            "TSEnableAll",
        },
        config = function() require "configs.treesitter" end,
    }

    -- Color highlighting
    use {
        "norcalli/nvim-colorizer.lua",
        event = { "BufRead", "BufNewFile" },
        config = function() require "configs.colorizer" end,
    }
    
    -- Autopairs
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require "configs.autopairs" end,
    }

    -- Terminal
    use {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        module = { "toggleterm", "toggleterm.terminal" },
        config = function() require "configs.toggleterm" end,
    }

    -- Commenting
    use {
        "numToStr/Comment.nvim",
        module = { "Comment", "Comment.api" },
        keys = { "gc", "gb", "g<", "g>" },
        config = function() require "configs.Comment" end,
    }

    -- Parenthesis highlighting
    use {
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter"
    }

    -- Autoclose tags
    use {
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter" 
    }

    -- Context based commenting
    use {
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter" 
    }

    -- Fuzzy finder
    use {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        module = "telescope",
        config = function() require "configs.telescope" end,
    }

    -- Fuzzy finder syntax support
    use {
        "nvim-telescope/telescope-fzf-native.nvim",
        after = "telescope.nvim",
        run = "make",
        config = function() require("telescope").load_extension("fzf") end,
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        after = "telescope.nvim",
        config = function() require("telescope").load_extension("file_browser") end,
    }

    if packer_bootstrap then
		require('packer').sync()
	end
end,

config = {
    max_jobs = 10,
    display = {
        open_fn = require('packer.util').float,
    }
}})
