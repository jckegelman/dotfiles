" Vim Settings
" John Kegelman

set nocompatible        " be iMproved, required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Vim bundles
Plugin 'tpope/vim-sensible'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-latex/vim-latex'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()         " required
filetype plugin indent on " required

"============= UI ========= ==================================================
set number       " show line numbers
set laststatus=2 " always show status line

set gfn=Monaco " font

if has('gui_running')
	set lines=35 columns=160 " adjust window size for gui
endif

"============= Key Mappings ==================================================

" Change leader key to <space>
nnoremap <space> <nop>
let mapleader="\<space>"

" press ; to issue commands in normal mode
nnoremap ; :

" pressing <leader><space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR>

" break a line at cursor without exiting normal mode
nnoremap <silent> <leader><CR> i<CR><ESC>

" insert a blank line with <leader>o
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>

" use jj to quickly escape to normal mode while typing
inoremap jj <ESC>

" use <leader>y/Y to copy to system clipboard
noremap <leader>y "+y
noremap <leader>Y "+Y

" use <leader>p/P to paste from system clipboard
noremap <leader>p :set paste<CR>"+]p:set nopaste<CR>
noremap <leader>P :set paste<CR>"+]P:set nopaste<CR>

" use +/- to increment/decrement numbers
nnoremap + <C-a>
nnoremap - <C-x>

" Ctrl+Backspace deletes last word
inoremap <C-BS> <ESC>bcw

" Ctrl-Del deletes next word
inoremap <C-Del> <ESC>wcw

" use <F2> to toggle paste mode
set pastetoggle=<F2>

"============= Buffers =======================================================

" buffers can exist in background
set hidden

" automatically save before commands
set autowrite

" buffer browsing with left/right arrows
nnoremap <Left> :bprev<CR>
nnoremap <Right> :bnext<CR>

" jump to previous buffer with Tab
nnoremap <Tab> <C-^>

" use Ctrl-Tab to toggle between splits
nnoremap <C-Tab> <C-W><C-W>

" split windows to the right
set splitright

"============= Session Handling ===============================================

" specify directory to save sessions
let g:session_dir = $HOME."/.vim/session"

" set session name using Ses command
command! -nargs=1 SessionName let g:sessionname=<f-args>
command! SessionCleanSave :set sessionoptions=blank,buffers,curdir,tabpages

" Save sessions whenever vim closes
autocmd VimLeave * call SaveSession()

" Load session when vim is opened
autocmd VimEnter * nested call OpenSession()

" Saves the session to session dir. Creates session dir if it doesn't
" yet exist. Sessions are named after servername parameter or g:sessionname
function! SaveSession()

	" get the server (session) name
	if exists("g:sessionname")
		let s = g:sessionname
	else
		let s = v:servername
	endif

	" create session dir if needed
	if !isdirectory(g:session_dir)
		call mkdir(g:session_dir, "p")
	endif

	" save session using the server name
	execute "mksession! ".g:session_dir."/".s.".session.vim"
endfunc

" Open a saved session if there were no file-names passed as arguments
" The session opened is based on servername (session name). If there
" is no session for this server, none will be opened
function! OpenSession()

	" check if file names were passed as arguments
	if argc() == 0

		let sn = v:servername
		let file = g:session_dir."/".sn.".session.vim"

		" if session file exists, ask user if he wants to load it
		if filereadable(file)
			if(confirm("Load last session?\n\n".file, "&Yes\n&No", 1)==1)
				execute "source ".file
			endif
		endif

	endif
endfunc

"============= Spell Check ===================================================
set spell          " enable in-line spellcheck
set spelllang=en

"============= Scrolling and Position ========================================
set cursorline           " highlight line with cursor

if v:version >= 703
	set colorcolumn=80 " highlight column 80
endif

set scrolloff=3          " 3 line offset when scrolling

set guicursor=a:blinkon0 " turn off cursor blink

"============= Search & Matching =============================================

set showcmd   " show partial command in status line
set showmatch " show matching brackets

set incsearch " incremental search
set hlsearch  " highlight search

set ignorecase " case-insensitive search
set smartcase  " case-sensitive for searches with uppercase

"============= Syntax Highlighting & Indents =================================

syntax enable  " enable syntax highlighting

set autoindent " always indent

set backspace=indent,eol,start " backspace over everything in insert mode

"============= Swap Files ====================================================

set noswapfile " suppress creation of swap files
set nobackup   " suppress creation of backup files
set nowb       " suppress creation of ~ files

"============= Solarized ======================================================

if has('gui_running')
	set background=light
else
	set t_Co=256
	let g:solarized_termcolors=256
	set background=dark
endif

colorscheme solarized

"============= LaTeX =========================================================
set shellslash

set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'
let g:Tex_CompileRule_pdf = "pdflatex -interaction=nonstopemode %:r & bibtex %:r & pdflatex -interaction=nonstopmode %:r"
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'