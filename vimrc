set nocompatible

" -- Plug
call plug#begin()

Plug 'hail2u/vim-css3-syntax'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'lilydjwg/colorizer'
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx'] }
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx'] }
Plug 'rking/ag.vim'
Plug 'szw/vim-tags'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-repeat'
Plug 'trevordmiller/nova-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/Align'

call plug#end()

let mapleader = ","        " Remap leader to ','
syntax on                  " Turn on color syntax highlighting
syntax enable
set t_Co=256
colorscheme nova

set encoding=utf-8
set number                           " Show line numbers
set laststatus=2                     " Always show status line
set nowrap                           " Do not wrap lines
set splitright                       " Opens vertical split right of current window
set splitbelow                       " Opens horizontal split below current window
set ttyfast                          " Send more characters for redraws
set hlsearch                         " Highlight search results
set grepprg=ag\ --nogroup\ --nocolor " Use ag over grep
set backspace=2                      " Make backspace work
set incsearch                        " Highlight search matches as I type

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

" Undo stuff
set undofile
set undodir=~/.vimundo/

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" -- Mappings

" Go to spec for current file
noremap <C-t> :A<CR>

" Show recently opened files
noremap <C-f> :History<CR>

" Open FZF
noremap <C-p> :FZF<CR>

" Clear search highlights
noremap <SPACE> :noh<CR>

" Copy current filename to system clipboard (wonky but works for now)
noremap <Leader>yf :!echo % \| pbcopy<CR><CR>

" Toggle netrw
noremap <Leader>m :Explore<CR>

" Close all except this window
noremap <Leader>o :only<CR>

" Remove whitespace
noremap <Leader>w :FixWhitespace<CR>

" Backslash as shortcut to ag
nnoremap \ :Ag<SPACE>

" Shift+K to search for the word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" When in insert mode, expand `pry`
inoremap pry require 'pry'; binding.pry

" Reformat visual selection as JSON
noremap <Leader>j !json_reformat<CR>

" Copy selected text to https://carbon.now.sh/
noremap <Leader>c :CarbonNowSh<CR>

" Get off my lawn
" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>

" vim-test
map <Leader>t :TestFile<CR>
map <Leader>s :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>a :TestSuite<CR>

let test#strategy = "dispatch"
let test#ruby#rspec#executable = 'bin/rspec --format doc --no-color'

let g:carbon_now_sh_browser = 'open'

" netrw customizations
let g:netrw_liststyle=3
let g:netrw_banner=0

" -- Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
let g:airline_theme='nova'
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
