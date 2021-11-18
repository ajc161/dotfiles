vim.o.background = "dark"
vim.o.termguicolors = true

local base16_background_path = vim.fn.expand "~/.vimrc_background"
if vim.fn.filereadable(base16_background_path) then
  vim.cmd("source " .. base16_background_path)
end
