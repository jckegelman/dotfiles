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
Plug 'airblade/vim-gitgutter'
Plug 'edkolev/tmuxline.vim'
Plug 'eiginn/netrw'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'lervag/vimtex'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-commentary',    { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/ReplaceWithRegister'

call plug#end()

" detect OS
if has("win32") || has("win32unix")
    let s:os = "Windows"
else
    let s:os = substitute(system('uname'), '\n', '', '')
endif

"============= Options ===================================================

set autoindent                 " always indent
set autoread                   " automatically read changed files
set autowrite                  " automatically save before commands
set backspace=indent,eol,start " backspace over everything in insert mode
set clipboard=unnamed          " copy/paste to system clipboard
set cmdheight=2                " use 2 lines for command line
set complete-=i                " do not search includes for completions
set cursorline                 " highlight line with cursor
set expandtab                  " use spaces instead of <TAB>
set guicursor=a:blinkon0       " turn off cursor blink
set hidden                     " buffers can exist in background
set history=200                " remember 200 previous commands
set hlsearch                   " highlight search
set ignorecase                 " case-insensitive search
set incsearch                  " incremental search
set laststatus=2               " always show status line
set lazyredraw                 " only redraw screen when needed
set list                       " show following whitespace characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set mouse=a                    " enable mouse for all modes
set nobackup                   " suppress creation of backup files
set nostartofline              " keep cursor on same column
set noswapfile                 " suppress creation of swap files
set nowb                       " suppress creation of ~ files
set number                     " show line numbers
set pastetoggle=<F2>           " <F2> toggles paste mode
set scrolloff=3                " 3 row offset when scrolling
set shiftround                 " round indent to multiple of 'shiftwidth'
set showcmd                    " show partial command in status line
set showmatch                  " show matching brackets
set sidescrolloff=5            " 5 column offset when scrolling
set smartcase                  " case-sensitive for searches with uppercase
set smarttab                   " <TAB> at start of line, spaces elsewhere
set spelllang=en_us            " check spelling with American English
set softtabstop=4              " <TAB> and <BS> for 4 spaces
set t_Co=256                   " use 256 colors
set ttimeout                   " timeout on key mappings
set ttimeoutlen=100            " reduce key timeout to 100ms
set visualbell                 " use visual bell instead of beeping
set wildmenu                   " better command-line completion
set wildmode=full              " complete the next full match

if has('gui_running')
    set lines=35 columns=108   " adjust window size for gui
    if s:os == "Darwin"
        set guifont=Meslo\ LG\ M\ Regular
    elseif s:os == "Windows"
        set guifont=Monaco
    endif
endif

if exists('&colorcolumn')
    set colorcolumn=120        " highlight column 120
endif

" join commented lines intelligently
if has('patch-7.3.541')
    set formatoptions+=j
endif

"============= Key Mappings ==================================================

" map Leader key to <Space>
nnoremap <Space> <nop>
let mapleader = "\<Space>"

" Y yanks until EOL
nnoremap Y y$

" paste from system clipboard
if s:os == "Darwin"
    " special case for iTerm2
    noremap <Leader>p :read !pbpaste<CR>
endif

" ';' issues commands in normal mode
nnoremap ; :

" <C-L> clears the search highlights
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Ctrl-BS deletes last word in insert mode
inoremap <C-BS> <ESC>bcw

" Ctrl-Del deletes next word in insert mode
inoremap <C-Del> <ESC>wcw

" reselect vidual block after indent/outdent
xnoremap < <gv
xnoremap > >gv

" <Leader>T opens a new empty buffer
nnoremap <Leader>T :enew<CR>

" <Leader>bq closes the current buffer and moves to the previous one
nnoremap <Leader>bq :bp <bar> bd #<CR>

" modify undo behavior in insert mode
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" save with <Leader>
nnoremap <Leader>s :update<CR>
nnoremap <Leader>w :update<CR>

" quit with <Leader>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>

" escape insert mode with "jj"
inoremap jj <ESC>

" movement in insert mode
inoremap <C-H> <C-O>h
inoremap <C-L> <C-O>l
inoremap <C-J> <C-O>j
inoremap <C-K> <C-O>k
inoremap <C-^> <C-O><C-^>

" circular windows navigation
nnoremap <TAB>   <C-W>w
nnoremap <S-TAB> <C-W>W

"============= handy commands  ===============================================

" from tpope on github
" increase/decrease gui font size with ":Bigger" / ":Smaller"
command! -bar -nargs=0 Bigger  :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)+1','')
command! -bar -nargs=0 Smaller :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)-1','')

augroup vimrc
    autocmd!
    autocmd FocusGained * if !has('win32') | silent! call fugitive#reload_status*() | endif
    autocmd FileType gitcommit setlocal spell
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>
    autocmd FocusLost * silent! :wa
augroup END

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

"============= vim-easy-align ================================================

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['m'] = {
\ 'pattern': ',\|\([)\]}];\)',
\ 'left_margin': 0,
\ 'stick_to_left': 0
\ }

"============= LaTeX & vimtex ================================================

let g:tex_flavor='latex'            " correct filetype detection
let g:vimtex_imaps_Leader = ';'     " change insert mode Leader key from '`' to ';'
let g:vimtex_latexmk_continuous = 0 " disable continuous mode
let g:vimtex_latexmk_background = 1 " compile in background

" configure PDF viewer
if s:os == "Darwin"
    let g:vimtex_view_general_viewer  = '/Applications/Skim.app/Contents/SharedSupport/displayline'
    let g:vimtex_view_general_options = '-r @line @pdf @tex'
    let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
    function! UpdateSkim(status)
        if !a:status | return | endif

        let l:out = b:vimtex.out()
        let l:tex = expand('%:p')
        let l:cmd = [g:vimtex_view_general_viewer, '-r']
        if !empty(system('pgrep Skim'))
            call extend(l:cmd, ['-g'])
        endif
        if has('nvim')
            call jobstart(l:cmd + [line('.'), l:out, l:tex])
        elseif has('job')
            call job_start(l:cmd + [line('.'), l:out, l:tex])
        else
            call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
        endif
    endfunction
elseif s:os == "Windows"
    let g:vimtex_view_general_viewer  = 'SumatraPDF'
    let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_latexmk_callback = 0
endif

"============= syntastic =====================================================

let g:syntastic_always_populate_loc_list = 1 " fill location-list with errors
let g:syntastic_auto_loc_list = 2            " do not auto open but auto close location-list
let g:syntastic_loc_list_height = 5          " height of location-list
let g:syntastic_check_on_open = 1            " check when buffer is loaded
let g:syntastic_check_on_wq = 0              " do not check when file is saved just before quit
let g:syntastic_tex_chktex_args = "-l ~/.chktexrc" " load a chktexrc file with chktex

"============= vim-commentary ================================================

map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
autocmd FileType matlab setlocal commentstring=%\ %s

"============= vim-fugitive ==================================================

nmap     <Leader>g :Gstatus<CR>gg<C-n>
nnoremap <Leader>d :Gdiff<CR>

"============= vim-surround ==================================================

" enable automatic re-indenting
let g:surround_indent = 1

"============= vim-airline ===================================================

let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1                " enable powerline symbols
let g:airline#extensions#tabline#enabled = 1     " show list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " show just the file name

"============= matchit.vim ===================================================

" extend "%" matching
runtime macros/matchit.vim

"============= tmuxline.vim ==================================================

let g:tmuxline_preset = {
    \'a'    : '#S',
    \'b'    : '#W',
    \'cwin' : ['#I', '#W'],
    \'win'  : ['#I', '#W'],
    \'x'    : '#{?client_prefix,Prefix,      }',
    \'y'    : ['%a', '%e-%b-%Y', '%l:%M%p'],
    \'z'    : '#h'}
