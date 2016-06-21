" Vim Settings
" John Kegelman

" break compatibility with vi
set nocompatible

" Change leader key to <space>
nnoremap <space> <nop>
let mapleader="\<space>"

" font
set gfn=Monaco

" UI options
if has('gui_running')
	set lines=35 columns=160
endif

"============= Key Mappings ==================================================

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

"============= Line Numbers ==================================================
set number

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

"============= Syntax Highlighting & Indents =================================

syntax enable  " enable syntax highlighting

" enable filetype detection and loading of plugin and indent files
filetype plugin indent on

set autoindent " always indent
set copyindent " copy previous indent on autoindenting
set smartindent

set backspace=indent,eol,start " backspace over everything in insert mode

"============= Status Line ===================================================

set statusline=2 " always show status line

"============= Swap Files ====================================================

set noswapfile " suppress creation of swap files
set nobackup   " suppress creation of backup files
set nowb       " suppress creation of ~ files

"============= Pathogen =======================================================

execute pathogen#infect()

"============= Solarized ======================================================

if has('gui_running')
	set background=light
else
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
let g:Tex_ViewRule_pdf = "'C:\\Program Files\\SumatraPDF\\SumatraPDF.exe' -reuse-instance"
