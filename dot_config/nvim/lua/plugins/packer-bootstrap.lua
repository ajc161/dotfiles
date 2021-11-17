local present, packer = pcall(require, "packer")
local bootstrapped = false

if not present then
  local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

  vim.fn.delete(packer_path, "rf")
  vim.fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_path }

  present, packer = pcall(require, "packer")

  if present then
    bootstrapped = true
  end
end

if not present then
   error("Failed to bootstrap packer")
end

return packer, bootstrapped
