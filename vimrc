"" to avoid non-utf errors
scriptencoding utf-8
set encoding=utf-8

"" appearance
" color scheme
set t_Co=256
colorscheme advantage

" count of lines w\o scrolling at the top and bottom
set scrolloff=3

" show running command
set showcmd

" blink instead of beep
set visualbell

" syntax higlighting
syntax on
" apply file types
filetype on
filetype plugin on
" show brakets for HTML-tags
set matchpairs+=<:>
" show first braket after typing second one
set showmatch

" show line number
set number
" red strip at 80 symbol
set colorcolumn=80

" enable tabs at the beginning of the line
set list
" show tabs
set listchars=tab:␉·,trail:␠,nbsp:⎵

" dymanic wrapping
set wrap
" wrap on words
set linebreak

"" tabs
set tabstop=4
set smarttab
set et
tab sball
set switchbuf=useopen
" width
set shiftwidth=2
" indents
set ai
" C-style indents
set cin

"" search
" highlight search results
set hlsearch
" search on typing
set incsearch
" case-insensetive search
set ignorecase

"" navigation
" save indents on paste
set pastetoggle=<F2>

" move coursor on typing
set whichwrap=b,<,>,[,],l,h

"" codepages and formats
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

set mousemodel=popup
set ruler
set completeopt-=preview

" autostart nerdtree if no any other args
autocmd vimenter * if !argc() | NERDTree | endif

" remove spaces at the end of the lines
autocmd BufWritePre * :%s/\s\+$//e

"" plugin settings
" airline settigns
set laststatus=2
let g:airline_theme='murmur'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'

" nerdtree settings
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', '\.o$']

" tagbar settings
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus=0

" tasklist
map <F5> :TaskList<CR>
