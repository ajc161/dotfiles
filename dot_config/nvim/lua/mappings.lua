local M = {}

M.nonplugin = function() 
  local set_keymap = vim.api.nvim_set_keymap
  local opts = { noremap=true, silent=true }

  set_keymap("n", "<Leader><Enter>", [[<Cmd>15 new +terminal<CR>]], opts)
end

M.lspconfig = function()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gk", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "ge", "<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<Leader>D", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

  buf_set_keymap("n", "[e", "<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]e", "<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  buf_set_keymap("n", "<Leader>wa", "<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wr", "<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wl", "<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<Leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<Leader>q", "<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<Leader>f", "<Cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

M.cmp = function()
  local cmp = require("cmp")

  return {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end,
  }
end

M.nvimtree = function()
  local set_keymap = vim.api.nvim_set_keymap
  local opts = { noremap=true, silent=true }

  set_keymap("n", "<Leader>t", [[<Cmd>lua require("nvim-tree").toggle(false)<CR>]], opts)
  set_keymap("n", "<Leader>T", [[<Cmd>lua require("nvim-tree").find_file(true)<CR>]], opts)
  set_keymap("n", "<Leader>te", [[<Cmd>lua require("nvim-tree").focus()<CR>]], opts)
end

M.bufferline = function()
  local set_keymap = vim.api.nvim_set_keymap
  local opts = { noremap=true, silent=true }

  set_keymap("n", "]b", [[<Cmd>lua require("bufferline").cycle(1)<CR>]], opts)
  set_keymap("n", "[b", [[<Cmd>lua require("bufferline").cycle(-1)<CR>]], opts)
  set_keymap("n", "gb", [[<Cmd>lua require("bufferline").pick_buffer()<CR>]], opts)
end

M.telescope = function()
  local set_keymap = vim.api.nvim_set_keymap
  local opts = { noremap=true, silent=true }

  set_keymap("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], opts)

  set_keymap("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], opts)
  set_keymap("n", "<Leader>fF", [[<Cmd>lua require("telescope.builtin").find_files({hidden=true})<CR>]], { noremap = true, silent = true })
  set_keymap("n", "<Leader>fo", [[<Cmd>lua require("telescope.builtin").oldfiles()<CR>]], opts)

  set_keymap("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], opts)

  set_keymap("n", "<Leader>fv", [[<Cmd>lua require("telescope.builtin").git_status()<CR>]], opts)
  set_keymap("n", "<Leader>fV", [[<Cmd>lua require("telescope.builtin").git_commits()<CR>]], opts)

  set_keymap("n", "<Leader>fs", [[<Cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>]], opts)

  set_keymap("n", "<Leader>fm", [[<Cmd>lua require("telescope.builtin").keymaps()<CR>]], opts)

  set_keymap("n", "<Leader>fh", [[<Cmd>lua require("telescope.builtin").help_tags()<CR>]], opts)
end

return M
