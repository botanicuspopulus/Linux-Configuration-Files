"""""""""""""""""""""""""""""""""""""""""""""
" Plugin Manager
"""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

call plug#begin()

Plug 'neovim/nvim-lsp'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'vim-syntastic/syntastic'
Plug 'tpope/vim-surround'

Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf.vim', { 'do': 'yes \| ./install' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'altercation/vim-colors-solarized'

Plug 'alvan/vim-closetag'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'
Plug 'JuliaEditorSupport/julia-vim'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""
" Vim Settings
"""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
filetype indent on
syntax enable
set ffs=unix,dos,mac

set shortmess+=c

set path+=**
set encoding=utf-8

" Wrapping Settings
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]
set complete-=i

" Indentation Settings
set nowrap
set autoindent
set smarttab
set expandtab
set shiftwidth=2
set shiftround
set tabstop=2
set softtabstop=2

" Search Settings
set incsearch
set hlsearch
set ignorecase
set smartcase
set magic

" Visual Settings
set title
set ruler
set hidden
set showcmd
set cursorline
set showmatch
set mat=2
set numberwidth=2
set matchpairs+=<:>
set cpoptions+=n
set lazyredraw
set ttyfast
set wildmenu
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set wildignore=*.o,*.pyc,*.so,*.lib,*~
set wildignore+=*.swp,*.zip
set wildignore+=*/tmp/*,*/.git/*,*/.hg/*,*/.svn/*
set number relativenumber

set background=dark
colorscheme solarized

:augroup numbertoggle
: autocmd!
: autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set relativenumber | endif
: autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set norelativenumber | endif
:augroup END

set foldcolumn=2
set cmdheight=1
set laststatus=2

set scrolloff=5
set sidescroll=5

set display+=lastline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set noerrorbells

" Folding Settings
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" File Settings
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set autoread
set history=999
set tabpagemax=50
set modelines=0
set formatoptions+=j

"""""""""""""""""""""""""""""""""""""""""""""
" File Related Settings
"""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre *.txt,*.js,*.py,*.cpp,*.h,*hpp,*.sh :call StripExtraSpaces()

autocmd filetype html,xml set listchars-=tab:>
autocmd filetype html,css,cml,xslt set shiftwidth=2 softtabstop=2 tabstop=2
autocmd filetype make set noexpandtab shiftwidth=2 softtabstop=2

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

au FileType python map <buffer> F :set foldmethod=indent<CR>

"""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","

nnoremap <leader>rvc :source ~/.vimrc<CR>
map <silent> <leader><Enter> :nohlsearch<CR>

" Window Navigation
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

noremap <leader>ss <:call StripExtraSpaces()<CR>
nnoremap <space> za
nnoremap j gj
nnoremap k gk

inoremap jk <esc>

map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove<CR>
map <leader>tp :tabprev<CR>
map <leader><leader> :tabnext<CR>
map <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

set pastetoggle=<F2>

let g:lasttab=1
nnoremap <leader>tl :exe "tabn".g:lasttab<CR>
au TabLeave * let g:lasttab=tabpagenr()

" NERDTree Related Key Mappings
map <silent> <leader>nn :NERDTreeToggle<CR>
map <silent> <leader>nb :NERdTreeFromBookmark<Space>
map <silent> <leader>nf :NERDTreeFind<CR>
nmap <silent> <leader>nr :NERDTreeFocus<CR> \| R \| <C-w><C-p>

" YouCompleteMe
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ycm_key_list_select_complection = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

"""""""""""""""""""""""""""""""""""""""""""""
" Commands
"""""""""""""""""""""""""""""""""""""""""""""
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
command! MakeTags !ctags -R .


"""""""""""""""""""""""""""""""""""""""""""""
" Plugin Related Settings
"""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
let g:NERDTreeWinPos="left"
let NERDTreeShowHidden=0
let NERDTreeIgnore=['\.pyc$', '\.o$', '__pycache__']
let g:NERDTreeWinSize=35
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1

autocmd FileType nerdtree set norelativenumber
autocmd FileType taglist set norelativenumber

" CtrlP
let g:ctrlp_match_window='bottom,order:ttb'
let g:ctrlp_switch_buffer=0
let g:ctrl_working_path_mode=0
let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'

" YouCompletMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_global_ycm_extra_conf='/home/botanthebushpig/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'

" Exuberant Ctags
set tags=tags

" vim-closetag
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.php,*.pthml,*.js'

" Airline
let g:airline_theme="simple"

""""""""""""""""""""""""""""""""""""""""""""""
" Julia Editor Support
""""""""""""""""""""""""""""""""""""""""""""""
let g:default_julia_version = '1.5'

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = { 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', 'using LanguageServer; using Pkg; import StaticLint; import SymbolServer; env_path = dirname(Pkg.Types.Context().env.project_file); server = LanguageServer.LanguageServerInstance(stdin, stdout, env_path, ""); server.runlinter = true; run(server);'] }

""""""""""""""""""""""""""""""""""""""""""""""
" NCM2 Configuration
""""""""""""""""""""""""""""""""""""""""""""""
inoremap <c-c> <ESC>

" When the <ENTER> key is pressed while the popup menu is visible, it only
" hides the menu. Using this mapping to close the menu and also start a new
" line.

inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-Tab>"


au User Ncm2Plugin call ncm2#register_source({'name' : 'css', 'priority': 9, 'subscope_enable': 1, 'scope': ['css', 'scss'], 'mark': 'css', 'word_pattern': '[\w\-]+', 'complete_pattern': ':\s*', 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS']})

""""""""""""""""""""""""""""""""""""""""""""
" Help Functions
"""""""""""""""""""""""""""""""""""""""""""""
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	endif
	return ''
endfunction

function! StripExtraSpaces()
    if !&binary && &filetype != 'diff'
        normal mz
        normal Hmy
        silent! %s/\s\+$//e
        normal 'yz<CR>
        normal `z
    endif
endfunction
