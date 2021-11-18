local packer, bootstrapped = require("plugins.packer-bootstrap")()

packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Plug Language extensions
  use "rust-lang/rust.vim"

  -- Colors
  use {
    "chriskempson/base16-vim",
    config = function()
      require("colors")
    end
  }

  -- File Browser
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    module = "nvim-tree",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFileToggle" },
    setup = function()
      require("nvim-tree").setup {}
      require("mappings").nvimtree()
    end
  }

  -- Fuzzy Finder
  use {
    "nvim-telescope/telescope.nvim",
    requires = "nvim-lua/plenary.nvim",
    module = "telescope",
    cmd = "Telescope",
    setup = function()
      require("mappings").telescope()
    end
  }

  -- Automatically sync plugins when bootstrapping packer
  if bootstrapped then
    require("packer").sync()
  end
end)
