" not compatible with the old-fashion vi mode
set nocompatible
" 256 color mode
set t_Co=256
" encoding utf-8
set encoding=utf-8
" set unix file format
set fileformat=unix
" fix background color bug (Kitty term)
let &t_ut=''
" no backup or swap, autoread file when external edited
set nobackup nowritebackup noswapfile autoread
" search
set hlsearch incsearch ignorecase smartcase
" show cursor position in status bar
set ruler
" show absolute line number of the current line
set number
" disable unloading of buffers
set hidden
" set shorter delays
set timeoutlen=1000 ttimeoutlen=10 updatetime=100
" remove current mode status
set noshowmode
" disable code folding
set nofoldenable
" set maximum number of tabs
set tabpagemax=50
" scroll the window so we can always see 10 lines around the cursor
set scrolloff=10
" turn off alt shortcuts
set winaltkeys=no

" disable annoying sound on errors
set noerrorbells
set novisualbell
set vb t_vb=

" set ident defaults
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

syntax on
filetype plugin indent on
" show special chars
set list
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

" Install vim-plug if not available
if empty(glob("~/.vim/autoload/plug.vim"))
	execute '!curl --create-dirs -SLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
else
	" Start vim-plug manager
	call plug#begin('~/.vim/plugged') 
	" Jellybeans (Theme)
	Plug 'nanotech/jellybeans.vim'
	" Airline (Status bar)
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	" NERDTree (File browser)
	Plug 'preservim/nerdtree'
	" CtrlP (File browser)
	Plug 'ctrlpvim/ctrlp.vim'
	" Fugitive (Git)
	Plug 'tpope/vim-fugitive'
	" GitGutter (Git diff)
	Plug 'airblade/vim-gitgutter'
	" Todo (Todo.txt)
	Plug 'freitass/todo.txt-vim'
	" Syntastic (Syntax checking)
	Plug 'vim-syntastic/syntastic'
	" Puppet (Puppet)
	Plug 'rodjek/vim-puppet'
	" Tabular (Identing shortcuts)
	Plug 'godlygeek/tabular'
	" Markdown (Markdown preview)
	Plug 'plasticboy/vim-markdown'
	" GPG (GPG encrypt/decrypt)
	Plug 'jamessan/vim-gnupg'
	call plug#end()
endif

" todo command
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw
" create readable JSON view
command! ShowJSON %!python -m json.tool

" date/time shortcuts
inoremap <script> <silent> <buffer> time<Tab> <C-R>=strftime("%H:%M")<CR>
inoremap <script> <silent> <buffer> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>

" set column identifier
set colorcolumn=110

" set colorscheme
silent! colorscheme jellybeans

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_puppet_checkers=['puppetlint']
let g:syntastic_python_checkers = ['flake8']

" Ctrl P
let g:ctrlp_show_hidden = 1

" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
" do not count whitespaces
let g:airline#extensions#whitespace#enabled=0
" set theme
silent! let g:airline_theme='minimalist'

