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
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'eiginn/netrw'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'psf/black'
Plug 'qpkorr/vim-bufkill'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-commentary',    { 'on': '<Plug>Commentary' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'uarun/vim-protobuf'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'vim-utils/vim-all'
Plug 'vim-utils/vim-man'
Plug 'vim-utils/vim-troll-stopper'
Plug 'zacanger/angr.vim'

call plug#end()

"============= editorconfig-vim ================================================
" make sure editorconfig works well with vim-fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"============= tmuxline.vim ====================================================
let g:tmuxline_preset = {
    \'a'    : '#S',
    \'b'    : '#W',
    \'c'    : '#(cd #{pane_current_path}; git rev-parse --abbrev-ref HEAD)',
    \'cwin' : ['#I', '#W'],
    \'win'  : ['#I', '#W'],
    \'x'    : '#{?client_prefix,Prefix,      }',
    \'y'    : ['%a', '%e-%b-%Y', '%l:%M%p'],
    \'z'    : '#h'}

"============= vim-cpp-enhanced-highlight ======================================
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_simple_template_highlight=1
let g:cpp_concepts_highlight=1

"============= vim-clang-format ================================================
let g:clang_format#command='clang-format-3.6'
let g:clang_format#detect_style_file=1
autocmd FileType c,cpp,objc let g:clang_format#auto_format=0

"============= vim-commentary ==================================================
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
autocmd FileType c,cpp,cs,java,proto setlocal commentstring=//\ %s
autocmd FileType matlab setlocal commentstring=%\ %s

"============= vim-fugitive ====================================================
nmap     <Leader>g :Gstatus<CR>gg<C-n>
nnoremap <Leader>d :Gdiff<CR>

"============= vim-surround ====================================================
" enable automatic re-indenting
let g:surround_indent = 1

"============= vim-airline =====================================================
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1                " enable powerline symbols
let g:airline#extensions#tabline#enabled = 1     " show list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " show just the file name
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

"============= matchit.vim =====================================================
" extend "%" matching
runtime macros/matchit.vim

"============= Autocommands ====================================================

augroup vimrc
    autocmd!
    autocmd FocusGained * silent! call fugitive#reload_status*()
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>
    autocmd FocusLost * silent! :wa
augroup END

" additional filetypes
augroup FileTypeAssociation
   autocmd!
   autocmd BufNewFile,BufRead *.impl,*.inl set filetype=cpp
   autocmd BufNewFile,BufRead *.launch set filetype=xml
   autocmd BufNewFile,BufRead *.make set filetype=make
augroup END

" Resize splits on window resize.
augroup AutoResizeSplits
   autocmd!
   autocmd VimResized * exe "normal! \<c-w>="
augroup END

"============= Settings ========================================================
set autoindent                 " always indent
set autoread                   " automatically read changed files
set autowrite                  " automatically save before commands
set backspace=indent,eol,start " backspace over everything in insert mode
set clipboard=unnamed          " copy/paste to system clipboard
set cmdheight=2                " use N lines for command line
set cursorline                 " highlight line with cursor
set expandtab                  " use spaces instead of <TAB>
set guicursor=a:blinkon0       " turn off cursor blink
set hidden                     " buffers can exist in background
set history=500                " remember N previous commands
set hlsearch                   " highlight search
set ignorecase                 " case-insensitive search
set incsearch                  " incremental search
set laststatus=2               " always show status line
set lazyredraw                 " only redraw screen when needed
set list                       " show following whitespace characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set nobackup                   " suppress creation of backup files
set noerrorbells               " no beeps on errors
set nojoinspaces               " insert one space after '.'
set nostartofline              " keep cursor on same column
set noswapfile                 " suppress creation of swap files
set nowb                       " suppress creation of ~ files
set number                     " show line numbers
set pastetoggle=<F2>           " <F2> toggles paste mode
set relativenumber             " show relative line numbers
set scrolloff=5                " N row offset when scrolling
set shiftround                 " round indent to multiple of 'shiftwidth'
set showcmd                    " show partial command in status line
set showmatch                  " show matching brackets
set sidescrolloff=10           " N column offset when scrolling
set smartcase                  " case-sensitive for searches with uppercase
set smarttab                   " <TAB> at start of line, spaces elsewhere
set spelllang=en_us            " check spelling with American English
set softtabstop=4              " <TAB> and <BS> for 4 spaces
set textwidth=80               " hard wrap at N characters.
set ttimeout                   " timeout on key mappings
set ttimeoutlen=100            " reduce key timeout to 100ms
set ttyfast                    " smoother redrawing.
set wildmenu                   " better command-line completion
set wildmode=list:longest,full " tab completion lists matches, then opens wildmenu on next <Tab>
set wrap                       " soft wrap lines.
set wrapscan                   " searching wraps to start of file when end is reached.

" Completion settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Options:
"     .        scan the current buffer ('wrapscan' is ignored)
"     w        scan buffers from other windows
"     b        scan other loaded buffers that are in the buffer list
"     u        scan the unloaded buffers that are in the buffer list
"     U        scan the buffers that are not in the buffer list
"     k        scan the files given with the 'dictionary' option
"     kspell   use the currently active spell checking |spell|
"     k{dict}  scan the file {dict}
"     s        scan the files given with the 'thesaurus' option
"     s{tsr}   scan the file {tsr}
"     i        scan current and included files
"     d        scan current and included files for defined name or macro |i_CTRL-X_CTRL-D|
"     t        tag completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set complete=.,w,b,u,t,i
autocmd FileType markdown,gitcommit,text setlocal complete+=k spell

" Text formatting settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Options:
"     t  Auto-wrap text using textwidth. (default)
"     c  Auto-wrap comments; insert comment leader. (default)
"     q  Allow formatting of comments with "gq". (default)
"     r  Insert comment leader after hitting <Enter>.
"     o  Insert comment leader after hitting 'o' or 'O' in command mode.
"     n  Auto-format lists, wrapping to text after the list bullet char.
"     l  Don't auto-wrap if a line is already longer than textwidth.
"     j  Join commented lines intelligently
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set formatoptions=tcqronlj

" Enable mouse scrolling in selected modes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Options:
"     a  All
"     c  Command
"     i  Insert
"     n  Normal
"     v  Visual
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=

" Color theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256                  " Use as many colors as your terminal supports.
silent! colorscheme angr      " Must be silent so vim-plug does not fail when installing for the first time.

if has('gui_running')
    set lines=35 columns=108   " adjust window size for gui
    set guifont=Meslo\ LG\ M\ Regular
endif

"============= Key Mappings ====================================================

" switch between *.h and *.cpp files and vice versa
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" paste from system clipboard (iTerm2)
noremap <Leader>p :read !pbpaste<CR>

"============= Normal mode =====================================================

" map Leader key to <Space>
nnoremap <Space> <nop>
let mapleader = "\<Space>"

" Y yanks until EOL
nnoremap Y y$

" No one ever intends to enter ex-mode. Make it harder by rebinding to QQ.
nnoremap Q <nop>
nnoremap QQ Q

" ';' issues commands in normal mode
nnoremap ; :

" <Ctrl-L> clears the search highlights
nnoremap <silent> <C-n> :nohlsearch<CR>:redraw!<CR>

" <Leader>T opens a new empty buffer
nnoremap <Leader>T :enew<CR>

" <Leader>bq closes the current buffer and moves to the previous one
nnoremap <Leader>bq :bp <bar> bd #<CR>

" save with <Leader>
nnoremap <Leader>s :update<CR>
nnoremap <Leader>w :update<CR>

" quit with <Leader>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>

" circular windows navigation
nnoremap <TAB>   <C-W>w
nnoremap <S-TAB> <C-W>W

" navigate windows with Ctrl-h/j/k/l
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Run clang-format on open file.
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>f :ClangFormat<CR>
nmap <Leader>F :ClangFormatAutoToggle<CR>

"============= Visual mode =====================================================

" reselect visual block after indent/outdent
xnoremap < <gv
xnoremap > >gv

" Run clang-format on visual selection.
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>f :ClangFormat<CR>

"============= Insert mode ===================================================

" Ctrl-BS deletes last word in insert mode
inoremap <C-BS> <ESC>bcw

" Ctrl-Del deletes next word in insert mode
inoremap <C-Del> <ESC>wcw

" modify undo behavior in insert mode
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" escape insert mode with "jj"
inoremap jj <ESC>

" movement in insert mode
inoremap <C-H> <C-O>h
inoremap <C-L> <C-O>l
inoremap <C-J> <C-O>j
inoremap <C-K> <C-O>k
inoremap <C-^> <C-O><C-^>
