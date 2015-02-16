"" appearance
" color scheme
colorscheme koehler

" count of lines w\o scrolling at the top and bottom
set scrolloff=3

" show running command
set showcmd

" status-line
set statusline=%t\ %y%m%r\ [%{&fileencoding}]%<\ [%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}]%k%=%-14.(%l,%c%V%)\ %P
" always show status-line
set laststatus=2

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
"set list
" show tabs
"set listchars=tab:

" dymanic wrapping
set wrap
" wrap on words
set linebreak


"" tabs
set tabstop=4
set smarttab
set et
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
set pastetoggle=P

" move coursor on typing
set whichwrap=b,<,>,[,],l,h


"" codepages and formats
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866


"" keyboard
" enable russian symbols
"set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" remove spaces at the end of the lines
autocmd BufWritePre * :%s/\s\+$//e
