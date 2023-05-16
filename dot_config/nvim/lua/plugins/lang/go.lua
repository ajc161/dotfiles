return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    -- TODO setup format imports on save
    -- try to use lazyvim hook?
    -- vim.api.nvim_create_autocmd('BufWritePre', {
    --   pattern = '*.go',
    --   callback = function()
    --     vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
    --   end
    -- })
    opts = {
      servers = {
        gopls = {
          settings = {
            analyses = {
              nilness = true,
              shadow = true,
              unusedparams = true,
              unusedvariable = true,
              unusedwrite = true,
              useany = true,
            },
            staticcheck = true,
          },
        },
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "delve" })
    end,
  },
}
