vim.cmd("set background=dark")
vim.cmd("set termguicolors")
vim.cmd("let base16colorspace=256")

local base16_background_path = vim.fn.expand "~/.vimrc_background"
if vim.fn.filereadable(base16_background_path) then
  vim.cmd("source " .. base16_background_path)
end
