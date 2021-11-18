local packer, bootstrapped = require("plugins.packer-bootstrap")()

packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  -- Plug Language extensions
  use "rust-lang/rust.vim"

  -- Colors
  use "chriskempson/base16-vim"

  -- File Browser
  use {
    "kyazdani42/nvim-tree.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require"nvim-tree".setup {} end
  }

  -- Fuzzy Finder
  use {
    "nvim-telescope/telescope.nvim",
    requires = {{"nvim-lua/plenary.nvim"}}
  }

  -- Automatically sync plugins when bootstrapping packer
  if bootstrapped then
    require("packer").sync()
  end
end)

--vim.api.nvim_buf_set_keymap(0, "", "cc", "line(".") == 1 ? "cc" : "ggcc"", { noremap = true, expr = true })

vim.api.nvim_set_keymap("n", "<Leader>t", [[<Cmd>lua require("nvim-tree").toggle(false)<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>tt", [[<Cmd>lua require("nvim-tree").find_file(true)<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>T", [[<Cmd>lua require("nvim-tree").refresh()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require("telescope.builtin").find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fg", [[<Cmd>lua require("telescope.builtin").live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require("telescope.builtin").buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require("telescope.builtin").help_tags()<CR>]], { noremap = true, silent = true })
