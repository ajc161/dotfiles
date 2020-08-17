" vim:fdm=marker

" plug {{{
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" languages
Plug 'rust-lang/rust.vim'

" language server and completion
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" git
Plug 'tpope/vim-fugitive'

" file browser
Plug 'scrooloose/nerdtree'

" fuzzy search
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'

" theme
Plug 'chriskempson/base16-vim'
call plug#end()
" }}}

" general {{{
let mapleader = ' '
let maplocalleader = ' '

set mouse=a
set hidden
set title
set lazyredraw
set showmatch
set foldcolumn=1

set scrolloff=7

set number
set relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup end

" whitespace
set tabstop=8
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent

" text width
set textwidth=100
set colorcolumn=+1

command! Bclose setl bufhidden=delete | bnext

" key bindingings
nnoremap <tab> <c-w>w
nnoremap <s-tab> <c-w>W

map <leader>bd :Bclose<cr>
map <leader>bl :bnext<cr>
map <leader>bh :bprevious<cr>

map <leader>tn :tabnew<cr>
map <leader>td :tabclose<cr>
map <leader>tl :tabnext<cr>
map <leader>th :tabprevious<cr>

map <leader>ss :setlocal spell!<cr>
map <leader>pp :setlocal paste!<cr>

noremap <silent> <leader>N :NERDTreeToggle<cr>
nmap <leader>G  :G<cr>
nnoremap <silent> <leader>V :e $MYVIMRC<cr>
nnoremap <leader>VV :source $MYVIMRC<cr>
" }}}

" search {{{
let $FZF_DEFAULT_OPTS .= ' --inline-info'
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

set dictionary+=/usr/share/dict/words

set ignorecase
set smartcase

if executable('fd')
  let FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
endif

if executable('rg')
  set grepprg=rg\ -i\ --vimgrep

  nnoremap <silent> <Leader>/ :Rg<Space>
endif

nnoremap <silent> <leader><leader> :Files<CR>
nnoremap <silent> <leader>B        :Buffers<CR>
nnoremap <silent> <leader>L        :Lines<CR>
nnoremap <silent> <leader>`        :Marks<CR>
nnoremap <silent> <leader>rg       :Rg <C-R><C-W><CR>
nnoremap <silent> <leader>RG       :Rg <C-R><C-A><CR>
xnoremap <silent> <leader>rg       y:Rg <C-R>"<CR>
nnoremap <silent> q:               :History:<CR>
nnoremap <silent> q/               :History/<CR>
nmap              <leader><esc>    <plug>(fzf-maps-n)
xmap              <leader><esc>    <plug>(fzf-maps-x)
omap              <leader><esc>    <plug>(fzf-maps-o)
" }}}

" completion {{{
let g:deoplete#enable_at_startup = 1
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rls'],
  \ 'java': ['jdtls', '-data', getcwd()],
  \ }

"set completeopt-=preview
autocmd InsertLeave * silent! pclose!

nnoremap <silent> <Leader>;  :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <Leader>K  :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd  :call LanguageClient#textDocument_definition()<CR>
" }}}

" theme {{{
set background=dark
let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
let g:airline_theme='base16_vim'
let g:airline_powerline_fonts = 1
" }}}
