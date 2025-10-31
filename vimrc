" =============================================================================
" VIM CONFIGURATION
" =============================================================================

" -----------------------------------------------------------------------------
" PLUGIN MANAGEMENT
" -----------------------------------------------------------------------------
call plug#begin()

" Themes
Plug 'chriskempson/tomorrow-theme'
Plug 'NLKNguyen/papercolor-theme'
Plug 'trevordmiller/nova-vim'

" UI & Navigation
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-rhubarb'

" Code Quality & Linting
Plug 'dense-analysis/ale'
Plug 'github/copilot.vim'

" Language Support
Plug 'hail2u/vim-css3-syntax', { 'for': ['css'] }
Plug 'lilydjwg/colorizer', { 'for': 'css' }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'jsx'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'jsx'] }
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }
Plug 'tpope/vim-rails', { 'for': ['ruby'] }

" Testing & Development
Plug 'janko-m/vim-test'
Plug 'tpope/vim-cucumber'

" Text Manipulation & Utilities
Plug 'szw/vim-tags'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/Align'

call plug#end()

" -----------------------------------------------------------------------------
" BASIC SETTINGS
" -----------------------------------------------------------------------------
let mapleader = ","                     " Remap leader to ','
syntax on                               " Turn on color syntax highlighting
set encoding=utf-8                      " Use UTF-8 encoding
set t_Co=256                            " Enable 256 colors
set background=dark                     " Dark background
colorscheme PaperColor                  " Set colorscheme

" -----------------------------------------------------------------------------
" DISPLAY & UI SETTINGS
" -----------------------------------------------------------------------------
set number                              " Show line numbers
set relativenumber                      " Show relative line numbers
set laststatus=2                        " Always show status line
set nowrap                              " Do not wrap lines
set wildmenu                            " Enhanced command completion

" -----------------------------------------------------------------------------
" PERFORMANCE SETTINGS
" -----------------------------------------------------------------------------
set lazyredraw                          " Don't redraw during macros
set updatetime=300                      " Faster completion
set ttyfast                             " Send more characters for redraws
set redrawtime=10000                    " Increase redraw time limit

" -----------------------------------------------------------------------------
" SEARCH SETTINGS
" -----------------------------------------------------------------------------
set hlsearch                            " Highlight search results
set incsearch                           " Highlight search matches as I type
set grepprg=rg\ --vimgrep\ --smart-case " Use ripgrep over grep

" -----------------------------------------------------------------------------
" SPLIT & WINDOW SETTINGS
" -----------------------------------------------------------------------------
set splitright                          " Opens vertical split right of current window
set splitbelow                          " Opens horizontal split below current window

" -----------------------------------------------------------------------------
" INDENTATION & TABS
" -----------------------------------------------------------------------------
set tabstop=2                           " Tab width
set softtabstop=2                       " Soft tab width
set shiftwidth=2                        " Shift width
set expandtab                           " Use spaces instead of tabs

" -----------------------------------------------------------------------------
" BACKUP & SWAP FILES
" -----------------------------------------------------------------------------
set noswapfile                          " Turn off swap files
set nobackup                            " Turn off backup files
set nowritebackup                       " Turn off write backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" -----------------------------------------------------------------------------
" UNDO SETTINGS
" -----------------------------------------------------------------------------
set undofile                            " Enable persistent undo
set undodir=~/.vimundo/                 " Undo directory

" -----------------------------------------------------------------------------
" SYSTEM INTEGRATION
" -----------------------------------------------------------------------------
set clipboard+=unnamed                  " Share the OS clipboard
set backspace=2                         " Make backspace work

" -----------------------------------------------------------------------------
" AUTOCMDS
" -----------------------------------------------------------------------------
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Remember last position in a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Set line width to 85 chars for Markdown files
au BufRead,BufNewFile *.md setlocal textwidth=85
au BufRead,BufNewFile *.markdown setlocal textwidth=85

" -----------------------------------------------------------------------------
" KEY MAPPINGS
" -----------------------------------------------------------------------------

" File Navigation
nnoremap <C-t> :A<CR>                   " Go to spec for current file
nnoremap <C-f> :History<CR>             " Show recently opened files
nnoremap <C-p> :FZF<CR>                 " Open FZF

" Search & Replace
nnoremap <SPACE> :noh<CR>               " Clear search highlights
nnoremap \ :Rg<SPACE>                   " Ripgrep search
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR> " Search word under cursor

" Window Management
nnoremap <C-j> <C-w>j                   " Move to window below
nnoremap <C-k> <C-w>k                   " Move to window above
nnoremap <C-h> <C-w>h                   " Move to window left
nnoremap <C-l> <C-w>l                   " Move to window right

" Window Resizing
nnoremap <S-Up>    <C-W>+               " Increase height
nnoremap <S-Down>  <C-W>-               " Decrease height
nnoremap <S-Left>  3<C-W>>              " Increase width
nnoremap <S-Right> 3<C-W><              " Decrease width

" Leader Key Shortcuts
nnoremap <Leader>yf :!echo % \| pbcopy<CR><CR> " Copy filename to clipboard
nnoremap <Leader>m :Explore<CR>         " Toggle netrw
nnoremap <Leader>o :only<CR>            " Close all except this window
nnoremap <Leader>w :%s/\s\+$//e<CR>     " Remove trailing whitespace
nnoremap <Leader>j :%!json_reformat<CR> " Reformat as JSON
nnoremap <Leader>c :only<CR> :vertical terminal<CR> " Open terminal in split
nnoremap <Leader>q :copen 5<CR>         " Open quickfix window

" Testing Shortcuts
map <Leader>t :only<CR> :TestFile<CR>   " Run test file
map <Leader>s :only<CR> :TestNearest<CR> " Run nearest test
map <Leader>l :only<CR> :TestLast<CR>   " Run last test
map <Leader>a :only<CR> :TestSuite<CR>  " Run all tests

" Disable Arrow Keys (Force hjkl usage)
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Insert Mode Shortcuts
inoremap pry require 'pry'; binding.pry " Expand pry in insert mode

" -----------------------------------------------------------------------------
" PLUGIN CONFIGURATIONS
" -----------------------------------------------------------------------------

" -- Airline Configuration
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.maxlinenr = ''
let g:airline_theme='papercolor'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_y = ''
let g:airline_section_z = '%l/%L:%v'

" -- FZF Configuration
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

" -- vim-test Configuration
function! TerminalSplit(cmd) abort
  9sp
  call term_start(['/bin/sh', '-c', a:cmd], {'curwin':1})
endfunction

let g:test#custom_strategies = {'terminal_split': function('TerminalSplit')}
let g:test#strategy = 'terminal_split'
let g:test#ruby#rspec#executable = 'bin/rspec'

" -- Language-specific Settings
let g:rustfmt_autosave = 1              " Auto-format Rust files
let g:html_indent_tags = 'li\|p'        " Treat <li> and <p> tags as block tags

" -- netrw Configuration
let g:netrw_liststyle=3                 " Tree style listing
let g:netrw_banner=0                    " Hide banner