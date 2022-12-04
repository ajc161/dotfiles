require("mason").setup {}

local inlay_hints = require("inlay-hints")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")

inlay_hints.setup {}

mason_lspconfig.setup {
  ensure_installed = {
    "rust_analyzer",
    "sumneko_lua",
  }
}

mason_lspconfig.setup_handlers {
  -- Default handler
  function(server_name)
    lspconfig[server_name].setup {}
  end,
  ["rust_analyzer"] = function()
    require("rust-tools").setup {
      tools = {
        on_initialized = function()
          inlay_hints.set_all()
        end,
        runnables = {
          use_telescope = true,
        },
        inlay_hints = {
          auto = false,
        },
      },
      server = {
        on_attach = function(client, bufnr)
          inlay_hints.on_attach(client, bufnr)
        end,
      },
    }
  end,
  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup {
      on_attach = function(client, bufnr)
        inlay_hints.on_attach(client, bufnr)
      end,
      settings = {
        Lua = {
          runtime = {
            -- Use LuaJIT with Neovim
            version = "LuaJIT",
          },
          diagnostics = {
            -- Recognize the `vim` global
            globals = {"vim"},
          },
          workspace = {
            -- Add Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          hint = {
            -- Turn on inlay hints
            enable = true,
          },
          telemetry = {
            -- Do not send telemetry data
            enable = false,
          },
        },
      },
    }
  end,
}
