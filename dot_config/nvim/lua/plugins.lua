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
    autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source <afile> | PackerCompile
  augroup end
]])

return packer.startup(function(use)
  use "wbthomason/packer.nvim"

  -- Library of Lua moules for NVIM
  use {
    "echasnovski/mini.nvim",
    config = [[require("config.mini")]],
  }

  -- Finder
  use {
    "nvim-telescope/telescope.nvim",
    config = [[require("config.telescope")]],
    requires = {
      { "nvim-lua/plenary.nvim" }
    },
  }

  -- File browser
  use {
    "kyazdani42/nvim-tree.lua",
    config = [[require("config.nvim-tree")]],
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  }

  use { "lewis6991/gitsigns.nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end
end)
