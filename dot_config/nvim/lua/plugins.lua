local ensure_packer = function()
  local repository = "https://github.com/wbthomason/packer.nvim"
  local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({"git", "clone", "--depth", "1", repository, install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local packer = require("packer")

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/*.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- TODO https://github.com/nvim-neorg/neorg

  -- Language server
  use {
    "neovim/nvim-lspconfig",
    config = [[require("config.lsp")]],
    requires = {
      { "simrat39/inlay-hints.nvim" },
      { "simrat39/rust-tools.nvim" },
      { "williamboman/mason.nvim", requires = { "williamboman/mason-lspconfig.nvim" } },
    },
  }

  -- Debug protocol
  use {
    "mfussenegger/nvim-dap",
    config = [[require("config.dap")]],
    requires = {
      "rcarriga/nvim-dap-ui",
    },
  }

  -- File tree
  use {
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = [[require("config.nvim-tree")]],
  }

  -- Finder
  use {
    "nvim-telescope/telescope.nvim",
    config = [[require("config.telescope")]],
    requires = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-packer.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-lua/plenary.nvim",
    },
  }

  -- Tree Sitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = [[require("config.treesitter")]],
  }

  -- Git status indicators
  use {
    "lewis6991/gitsigns.nvim",
    config = [[require("config.gitsigns")]],
  }

  -- Keymaps helper
  use {
    "folke/which-key.nvim",
    config = [[require("mappings")]],
  }

  -- Color
  use {
    "folke/tokyonight.nvim",
    config = [[require("config.tokyonight")]],
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
