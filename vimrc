"" .vimrc by arcanis
"" 2012-12-15

"" Внешний вид
" Цветовая схема
colorscheme koehler

" Число строк внизу и вверху экрана без прокрутки
set scrolloff=3

" Отображение выполняемой команды
set showcmd

" Status-line
set statusline=%t\ %y%m%r\ [%{&fileencoding}]%<\ [%{strftime(\"%d.%m.%y\",getftime(expand(\"%:p\")))}]%k%=%-14.(%l,%c%V%)\ %P
" Всегда показывать status-line
set laststatus=2

" Мигание вместо спикера
set visualbell

" Подсветка синтаксиса
syntax on
" Применять типы файлов
filetype on
filetype plugin on
" Показывать совпадающие скобки для HTML-тегов
set matchpairs+=<:>
" Показывать первую парную скобку после ввода второй
set showmatch

" Показывать номер строки
set number
" Красная полоска на 80 символе
set colorcolumn=80

" Включить табы в начале строки
"set list
" Обозначение табов в начале строки
"set listchars=tab:

" Динамический перенос длинных строк
set wrap
" Переносить словами
set linebreak


"" Табуляция
set tabstop=4
set smarttab
set et
" Ширина
set shiftwidth=2
" Автоотступы
set ai
" Отступы в стиле C
set cin


"" Поиск
" Подсветка результатов поиска
set hlsearch
" Поиск фрагмента по мере его набора
set incsearch
" Поиск без учёта регистра символов
set ignorecase


"" Навигация
" При вставке фрагмента сохраняет отступ
set pastetoggle=<P>

" Перемещать курсор на следующую строку при нажатии на клавиши
set whichwrap=b,<,>,[,],l,h


"" Кодировки и форматы (в порядке применения)
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866


"" Клавиатура
" Автоопределение русских символов
"set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
