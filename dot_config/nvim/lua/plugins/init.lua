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

  -- Language Server Protocol
  use {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")

      local on_attach = function(client, bufnr)
        require("mappings").lspconfig()
      end

      lsp.rust_analyzer.setup {
        cmd = { "rustup", "run", "nightly", "rust-analyzer" },
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    end
  }

  -- File Browser
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    module = "nvim-tree",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFileToggle" },
    setup = function()
      require("mappings").nvimtree()
    end,
    config = function()
      require("nvim-tree").setup {}
    end
  }

  -- Fuzzy Finder
  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons"},
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
