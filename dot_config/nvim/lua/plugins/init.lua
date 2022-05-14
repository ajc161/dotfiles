local packer, bootstrapped = require("plugins.packer-bootstrap")()

packer.startup({function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Language extensions
  use "rust-lang/rust.vim"
  -- TODO
  --use {
  --  "simrat39/rust-tools.nvim",
  --  module = "rust-tools",
  --  requires = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" }
  --}

  -- TODO vim-repeat
  -- TODO vim-fugitive

  -- Icons
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup {}
    end
  }

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
    after = "nvim-cmp",
    config = function()
      local lsp = require("lspconfig")

      local on_attach = function(client, bufnr)
        require("mappings").lspconfig()
      end

      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      lsp.rust_analyzer.setup {
        cmd = { "rust-analyzer" },
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }

      lsp.pyright.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }

    end
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = { "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip" },
    config = function()
      vim.o.completeopt = "menu,menuone,noselect"
      require("cmp").setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        mapping = require("mappings").cmp(),
        sources = {
          { name = "nvim_lsp" },
          { name = 'luasnip' },
        }
      }
    end
  }

  -- Treesitter (requires neovim nightly)
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        -- TODO java, ledger, nix
        ensure_installed = { "lua", "rust", "python", "toml" },
        highlight = {
          enable = true
        },
        incremental_selection = {
          enable = true
        }
      }
    end
  }

  -- File Browser
  use {
    "kyazdani42/nvim-tree.lua",
    after = "nvim-web-devicons",
    module = "nvim-tree",
    cmd = { "NvimTreeOpen", "NvimTreeToggle" },
    setup = function()
      require("mappings").nvimtree()
    end,
    config = function()
      require("nvim-tree").setup {}
    end
  }

  -- Statusline
  use {
    "famiu/feline.nvim",
    after = { "gitsigns.nvim", "nvim-web-devicons" },
    config = function()
      require("feline").setup {}
    end
  }

  use {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitsigns").setup {}
    end
  }

  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("mappings").bufferline()
      require("bufferline").setup {
        options = {
          offsets = {{ filetype = "NvimTree", text = "File Explorer" }},
          always_show_bufferline = false,
          diagnostics = "nvim_lsp",
          custom_filter = function(buffer)
            local buftype = vim.api.nvim_buf_get_option(buffer, "buftype")

            if (buftype == "terminal") then
              return false
            end

            return true
          end,
        }
      }
    end
   }

  -- Fuzzy Finder
  use {
    "nvim-telescope/telescope.nvim",
    after = "nvim-web-devicons",
    requires = {
      {
        "nvim-lua/plenary.nvim",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
      },
      {
        'nvim-telescope/telescope-ui-select.nvim',
      },
    },
    module = "telescope",
    cmd = "Telescope",
    setup = function()
      require("mappings").telescope()
    end,
    config = function() 
      local telescope = require("telescope")
      telescope.setup = {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }
          }
        }
      }

      print(vim.inspect(vim.ui.select))
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      print(vim.inspect(vim.ui.select))
    end
  }

  -- Automatically sync plugins when bootstrapping packer
  if bootstrapped then
    require("packer").sync()
  end
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})
