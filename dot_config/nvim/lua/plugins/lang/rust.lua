return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "rust", "toml" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb", "rust-analyzer", "taplo" })
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust_tools")
      -- setup codelldb https://github.com/simrat39/rust-tools.nvim/wiki/Debugging
      local mason_registry = require("mason-registry")
      local codelldb = mason_registry.get_package("codelldb")
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
        or extension_path .. "lldb/lib/liblldb.so"

      return {
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<leader>cR", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
}
