" 256 color mode
set t_Co=256
" encoding utf-8
set encoding=utf-8
" not compatible with the old-fashion vi mode
set nocompatible
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
set timeoutlen=1000 ttimeoutlen=10
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

" auto reload vimrc when editing it
autocmd! BufWritePost .vimrc source ~/.vimrc

" disable annoying sound on errors
set noerrorbells
set novisualbell
set vb t_vb=

syntax on
filetype plugin indent on

" Install vim-plug if not available
if empty(glob("~/.vim/autoload/plug.vim"))
	execute '!curl --create-dirs -SLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Start vim-plug manager
call plug#begin('~/.vim/plugged') 
" Jellybeans theme
Plug 'https://github.com/nanotech/jellybeans.vim.git'
" Airline
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
" CtrlP
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
" Fugitive - Git for airline
Plug 'https://github.com/tpope/vim-fugitive.git'
" Todo
Plug 'https://github.com/freitass/todo.txt-vim.git'
" Syntastic
Plug 'https://github.com/vim-syntastic/syntastic'
" Puppet
Plug 'https://github.com/rodjek/vim-puppet.git'
" Tabular
Plug 'https://github.com/godlygeek/tabular.git'
" Markdown
Plug 'https://github.com/plasticboy/vim-markdown.git'
" PlantUML
Plug 'https://github.com/aklt/plantuml-syntax.git'
" GPG
Plug 'https://github.com/jamessan/vim-gnupg.git'
" VimWiki
Plug 'https://github.com/vimwiki/vimwiki.git'
call plug#end()

" todo command
command! Todo noautocmd vimgrep /TODO\|FIXME/j ** | cw

" set netrw defaults
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=15

" set ident defaults
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" set column identifier
set colorcolumn=110

" set colorscheme
silent! colorscheme jellybeans

" VimWiki wiki defines
let wiki_work = {}
let wiki_work.path = '~/wiki/work/'
let wiki_work.syntax = 'markdown'
let wiki_work.ext = '.md'
let wiki_work.auto_tags = 1
let wiki_personal = {}
let wiki_personal.path = '~/wiki/personal/'
let wiki_personal.syntax = 'markdown'
let wiki_personal.ext = '.md'
let wiki_personal.auto_tags = 1
" VimWiki
let g:vimwiki_list = [wiki_work, wiki_personal]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
" do not count whitespaces
let g:airline#extensions#whitespace#enabled=0
" set theme
silent! let g:airline_theme='minimalist'
