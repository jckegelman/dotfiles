" Vim Settings
" John Kegelman

set nocompatible " be iMproved

" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" vim plugins
Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'lervag/vimtex'
Plug 'scrooloose/nerdtree',     { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vimwiki/vimwiki'

call plug#end()

" detect OS
if has("win32") || has("win32unix")
    let s:os = "Windows"
else
    let s:os = substitute(system('uname'), '\n', '', '')
endif

"============= UI ============================================================

set number                     " show line numbers
set laststatus=2               " always show status line
set wildmenu                   " better command-line completion
set mouse=a                    " enable mouse for all modes
set backspace=indent,eol,start " backspace over everything in insert mode
set cursorline                 " highlight line with cursor
set scrolloff=3                " 3 line offset when scrolling
set guicursor=a:blinkon0       " turn off cursor blink
set nostartofline              " keep cursor on same column

if has('gui_running')
    set lines=35 columns=108 " adjust window size for gui
    if s:os == "Darwin"
        set guifont=Meslo\ LG\ M\ Regular
    elseif s:os == "Windows"
        set guifont=Monaco
    endif
endif

if v:version >= 703
    set colorcolumn=80 " highlight column 80
endif

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

" <leader>T to open a new empty buffer
nmap <leader>T :enew<CR>

" <leader>bq to close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>

" automatically save before commands
"set autowrite

" buffer browsing with left/right arrows
"nnoremap <Left> :bprev<CR>
"nnoremap <Right> :bnext<CR>

" jump to previous buffer with Tab
"nnoremap <Tab> <C-^>

" use Ctrl-Tab to toggle between splits
"nnoremap <C-Tab> <C-W><C-W>

" split windows to the right
"set splitright

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
    let g:vimtex_view_general_viewer  = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_latexmk_callback = 0
endif

"============= airline =======================================================

" show list of buffers
let g:airline#extensions#tabline#enabled = 1

" show just the file name
let g:airline#extensions#tabline#fnamemod = ':t'

"============= CtrlP =========================================================

" custom ignores
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.git)$',
            \ 'file': '\v\.(png|jpg|jpeg)$',
            \}

" mappings for different modes
nmap <leader>bb :CtrlPBuffer<CR>
nmap <leader>bm :CtrlPMixed<CR>
nmap <leader>bs :CtrlPMRU<CR>

"============= vim-easy-align ================================================

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"============= syntastic =====================================================

" load a chktexrc file with chktex
let g:syntastic_tex_chktex_args = "-l ~/.chktexrc"
