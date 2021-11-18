local M = {}

--vim.api.nvim_buf_set_keymap(0, "", "cc", "line(".") == 1 ? "cc" : "ggcc"", { noremap = true, expr = true })

M.nvimtree = function()
  vim.api.nvim_set_keymap("n", "<Leader>t", [[<Cmd>lua require("nvim-tree").toggle(false)<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>tt", [[<Cmd>lua require("nvim-tree").find_file(true)<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>te", [[<Cmd>lua require("nvim-tree").focus()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>T", [[<Cmd>lua require("nvim-tree").refresh()<CR>]], { noremap = true, silent = true })
end

M.telescope = function()
  vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], { noremap = true, silent = true })

  vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>fF", [[<Cmd>lua require("telescope.builtin").find_files({hidden=true})<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require("telescope.builtin").oldfiles()<CR>]], { noremap = true, silent = true })

  vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], { noremap = true, silent = true })

  vim.api.nvim_set_keymap("n", "<Leader>fv", [[<Cmd>lua require("telescope.builtin").git_status()<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>fV", [[<Cmd>lua require("telescope.builtin").git_commits()<CR>]], { noremap = true, silent = true })

  vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require("telescope.builtin").help_tags()<CR>]], { noremap = true, silent = true })
end

return M
