set nocompatible

" -- Plug
call plug#begin()

Plug 'rking/ag.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'ctrlpvim/ctrlp.vim'
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
"Plug 'yegappan/mru'

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
set hlsearch       " Highlight search results

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

" -- Mappings

" Go to spec for current file
noremap <C-t> :A<CR>

" Show recently opened files
noremap <C-f> :MRU<CR>

" Clear search highlights
nmap <SPACE> :noh<CR>

" Copy current filename to system clipboard (wonky but works for now)
noremap <Leader>yf :!echo % \| pbcopy<CR><CR>

" Toggle NERDTree
noremap <Leader>m :NERDTreeToggle<CR>

" Remove whitespace
noremap <Leader>s :FixWhitespace<CR>

" When in insert mode, expand `pry`
inoremap pry require 'pry'; binding.pry

" -- Airline
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1

" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" -- CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -w -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" Search for the word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Backslash as shortcut to ag
nnoremap \ :Ag<SPACE>

" Remember last position in a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
