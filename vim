set nocompatible
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
Plug 'bronson/vim-trailing-whitespace'
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-repeat'

call plug#end()

let mapleader = ","
colorscheme Tomorrow-Night
autocmd vimenter * NERDTree
set nocursorcolumn
set nocursorline
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set nowrap
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [%l,%c]\ [%L,%p%%]
syntax sync minlines=256
syntax on
filetype plugin indent on

nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>m :NERDTreeFind<CR>
nmap <C-p> :CtrlP<CR>
