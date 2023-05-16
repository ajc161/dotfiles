local function get_python_path(workspace)
  local lsp_path = require("lspconfig.util").path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return lsp_path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(lsp_path.join(workspace, "pyproject.toml"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system("poetry --directory " .. workspace .. " env info -p"))
    return lsp_path.join(venv, "bin", "python")
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          before_init = function(_, config)
            config.settings.python.pythonPath = get_python_path(config.root_dir)
          end,
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "python" })
    end,
  },
}
