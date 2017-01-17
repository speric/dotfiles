set nocompatible

call plug#begin()

Plug 'rking/ag.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

let mapleader = ","        " Remap leader to ','
syntax on                  " Turn on color syntax highlighting
syntax enable
set t_Co=256
colorscheme Tomorrow-Night " The greatest vim theme ever
let NERDTreeShowHidden=1   " Show hidden files in NERDTree

set encoding=utf-8
set number         " Show line numbers
set laststatus=2   " Always show status line
set nowrap         " Do not wrap lines
set splitright     " Opens vertical split right of current window
set splitbelow     " Opens horizontal split below current window
set ttyfast        " Send more characters for redraws

" Tab stuff
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set wildmenu

" Turn Off Swap Files
set noswapfile
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Mappings
nmap <C-m> :NERDTreeToggle<CR>
nmap <C-p> :CtrlP<CR>
nmap <C-t> :A<CR>
nmap <C-s> :FixWhitespace<CR>

" Airline
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1
