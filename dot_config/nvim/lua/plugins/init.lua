local packer, bootstrapped = require("plugins.packer-bootstrap")

packer.startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  --Plug Language extensions
  use 'rust-lang/rust.vim'

  -- Colors
  use 'chriskempson/base16-vim'

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically sync plugins when bootstrapping packer
  if bootstrapped then
    require('packer').sync()
  end
end)
