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
Plugin 'lervag/vimtex'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()         " required
filetype plugin indent on " required

" detect OS
if has("win32")
    let s:os = "Windows"
else
    let s:os = substitute(system('uname'), '\n', '', '')
endif

"============= UI ============================================================
set number       " show line numbers
set laststatus=2 " always show status line
set wildmenu     " better command-line completion
set mouse=a      " enable mouse for all modes
set backspace=indent,eol,start " backspace over everything in insert mode

if has('gui_running')
    set lines=35 columns=108 " adjust window size for gui
    if s:os == "Darwin"
        set guifont=Meslo\ LG\ M\ Regular
    elseif s:os == "Windows"
        set guifont=Monaco
    endif
endif

set cursorline           " highlight line with cursor

if v:version >= 703
    set colorcolumn=80 " highlight column 80
endif

set scrolloff=3          " 3 line offset when scrolling

set guicursor=a:blinkon0 " turn off cursor blink

"============= Key Mappings ==================================================

" Change leader key to <space>
nnoremap <space> <nop>
let mapleader="\<space>"

" Y yanks until EOL
map Y y$

" ';' issues commands in normal mode
nnoremap ; :

" <leader><space> clears the search highlights
nmap <silent> <leader><space> :nohlsearch<CR>

" <leader><CR> breaks a line at cursor without exiting normal mode
nnoremap <silent> <leader><CR> i<CR><ESC>

" <leader>o/O inserts a blank line in normal mode
nnoremap <silent> <leader>o o<ESC>
nnoremap <silent> <leader>O O<ESC>

" jj escapes insert mode to normal mode
inoremap jj <ESC>

" <leader>y/Y copies to system clipboard
map <leader>y "+y
map <leader>Y "+Y " note recursive map here

" <leader>p/P pastes from system clipboard
noremap <leader>p :set paste<CR>"+]p:set nopaste<CR>
noremap <leader>P :set paste<CR>"+]P:set nopaste<CR>

" +/- increments/decrements numbers
nnoremap + <C-a>
nnoremap - <C-x>

" Ctrl+Backspace deletes last word
inoremap <C-BS> <ESC>bcw

" Ctrl-Del deletes next word
inoremap <C-Del> <ESC>wcw

" <F2> toggles paste mode
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

"============= Session Handling ==============================================

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

"============= Search & Matching =============================================

set showcmd   " show partial command in status line
set showmatch " show matching brackets

set incsearch " incremental search
set hlsearch  " highlight search

set ignorecase " case-insensitive search
set smartcase  " case-sensitive for searches with uppercase

"============= Syntax Highlighting & Indents =================================

syntax enable     " enable syntax highlighting

set autoindent    " always indent
set shiftwidth=4  " auto-indent with 4 spaces
set softtabstop=4 " <TAB> and <BS> for 4 spaces
set expandtab     " use spaces instead of TAB

"============= Swap Files ====================================================

set noswapfile " suppress creation of swap files
set nobackup   " suppress creation of backup files
set nowb       " suppress creation of ~ files

"============= Solarized =====================================================

if has('gui_running')
    set background=light
else
    set background=dark
endif

colorscheme solarized

"============= LaTeX & vimtex ================================================

let g:tex_flavor='latex'
if s:os == "Darwin"
    let g:vimtex_view_general_viewer  = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '-r @line @pdf @tex'
    let g:vimtex_view_general_options_latexmk = '-r 1'
elseif s:os == "Windows"
    let g:vimtex_view_general_viewer = 'SumatraPDF -reuse-instance '
                \ . '-inverse-search "gvim --servername ' . v:servername
                \ . ' --remote-send \"^<C-\^>^<C-n^>'
                \ . ':drop \%f^<CR^>:\%l^<CR^>:normal\! zzzv^<CR^>'
                \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
                \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
                \ . ':call remote_foreground('''.v:servername.''')^<CR^>\""'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif
