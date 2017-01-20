set nocompatible

" -- Plug
call plug#begin()

Plug 'bronson/vim-trailing-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'lilydjwg/colorizer'
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'szw/vim-tags'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
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
set number                           " Show line numbers
set laststatus=2                     " Always show status line
set nowrap                           " Do not wrap lines
set splitright                       " Opens vertical split right of current window
set splitbelow                       " Opens horizontal split below current window
set ttyfast                          " Send more characters for redraws
set hlsearch                         " Highlight search results
set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep

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

" Open FZF
noremap <C-p> :FZF<CR>

" Clear search highlights
noremap <SPACE> :noh<CR>

" Copy current filename to system clipboard (wonky but works for now)
noremap <Leader>yf :!echo % \| pbcopy<CR><CR>

" Toggle NERDTree
noremap <Leader>m :NERDTreeToggle<CR>

" Remove whitespace
noremap <Leader>w :FixWhitespace<CR>

" Backslash as shortcut to ag
nnoremap \ :Ag<SPACE>

" Search for the word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" When in insert mode, expand `pry`
inoremap pry require 'pry'; binding.pry

" vim-rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "Dispatch spring rspec {spec}"

" -- Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_y = ''
let g:airline_section_z = '%l/%L:%v'

" -- FZF
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_buffers_jump = 1

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Remember last position in a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
