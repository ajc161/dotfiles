require("telescope").setup {}

vim.keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<leader>fw", function() require("telescope.builtin").grep_string() end)
vim.keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep() end)
vim.keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end)
vim.keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags() end)
