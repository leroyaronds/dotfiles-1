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
" show special chars
set list
set listchars=eol:⏎,tab:␉·,trail:␠,nbsp:⎵

syntax on
filetype plugin indent on

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
    " Tagbar (Tags browser)
    Plug 'majutsushi/tagbar'
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
    " YouCompleteMe (Code completion)
    Plug 'Valloric/YouCompleteMe'
    " Puppet (Puppet)
    Plug 'rodjek/vim-puppet'
    " GPG (GPG encrypt/decrypt)
    Plug 'jamessan/vim-gnupg'
    " End vim-plug manager
    call plug#end()
endif

" todo command
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw
" create readable JSON view
command! ShowJSON %!python -m json.tool

" shortcuts
inoremap <script> <silent> <buffer> time<Tab> <C-R>=strftime("%H:%M")<CR>
inoremap <script> <silent> <buffer> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>
noremap <C-w>t :TagbarToggle<CR>
noremap <C-w>- :split<CR>
noremap <C-w>| :vsplit<CR>

" set column identifier
set colorcolumn=110

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
let g:syntastic_yaml_checkers = ['yamllint']

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1

" CtrlP
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
"if executable('rg')
"  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
"endif
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_max_files = 500
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(pyc|swp|vim)$',
    \ }

" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#whitespace#enabled=0

" Theme
silent! colorscheme jellybeans
silent! let g:airline_theme='minimalist'
