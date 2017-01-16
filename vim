set nocompatible

call plug#begin()

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

let mapleader = ","

syntax on
colorscheme Tomorrow-Night

set encoding=utf-8
set laststatus=2
set nowrap

nmap <leader>n :NERDTreeToggle<CR>
nmap <C-p> :CtrlP<CR>
nmap <C-t> :A<CR>

let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1
