local M = {}

--vim.api.nvim_buf_set_keymap(0, "", "cc", "line(".") == 1 ? "cc" : "ggcc"", { noremap = true, expr = true })

M.lspconfig = function()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>lD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

M.nvimtree = function()
  local set_keymap = vim.api.nvim_set_keymap
  local opts = { noremap=true, silent=true }

  set_keymap("n", "<leader>t", [[<cmd>lua require("nvim-tree").toggle(false)<CR>]], opts)
  set_keymap("n", "<leader>tt", [[<cmd>lua require("nvim-tree").find_file(true)<CR>]], opts)
  set_keymap("n", "<leader>te", [[<cmd>lua require("nvim-tree").focus()<CR>]], opts)
  set_keymap("n", "<leader>T", [[<cmd>lua require("nvim-tree").refresh()<CR>]], opts)
end

M.telescope = function()
  local set_keymap = vim.api.nvim_set_keymap
  local opts = { noremap=true, silent=true }

  set_keymap("n", "<leader>fb", [[<cmd>lua require("telescope.builtin").buffers()<CR>]], opts)

  set_keymap("n", "<leader>ff", [[<cmd>lua require("telescope.builtin").find_files()<CR>]], opts)
  set_keymap("n", "<leader>fF", [[<cmd>lua require("telescope.builtin").find_files({hidden=true})<CR>]], { noremap = true, silent = true })
  set_keymap("n", "<leader>fo", [[<cmd>lua require("telescope.builtin").oldfiles()<CR>]], opts)

  set_keymap("n", "<leader>fg", [[<cmd>lua require("telescope.builtin").live_grep()<CR>]], opts)

  set_keymap("n", "<leader>fv", [[<cmd>lua require("telescope.builtin").git_status()<CR>]], opts)
  set_keymap("n", "<leader>fV", [[<cmd>lua require("telescope.builtin").git_commits()<CR>]], opts)

  set_keymap("n", "<leader>fh", [[<cmd>lua require("telescope.builtin").help_tags()<CR>]], opts)
end

return M
