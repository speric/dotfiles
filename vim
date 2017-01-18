set nocompatible

call plug#begin()

Plug 'rking/ag.vim'
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yegappan/mru'

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
noremap <C-t> :A<CR>         " Go to spec for current file
noremap <C-f> :MRU<CR>       " Show recently opened files
nmap <SPACE> <SPACE>:noh<CR> " Clear results of last search

" Copy current filename to system clipboard (wonky but works for now)
noremap <Leader>yf :!echo % \| pbcopy<CR><CR>
noremap <Leader>m :NERDTreeToggle<CR> " Toggle NERDTree
noremap <Leader>s :FixWhitespace<CR>

" When in insert mode, expand `pry`
inoremap pry require 'pry'; binding.pry

" Airline
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <C-p> :call SelectaCommand("find * -type f", "", ":e")<cr>

" Remember last position in a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
