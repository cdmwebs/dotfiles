" Window size
set winwidth=85
let g:halfsize=86
let g:fullsize=171
set lines=70
let &columns=g:halfsize

" Font
set guifont=Monaco:h10.00

" Use console dialogs
set guioptions+=c

" turns the toolbar on
set go+=T

" turns the toolbar off
"set go-=T

" add a cursorline
set cursorline

"colorscheme railscasts
colorscheme vividchalk

" w00t
set bg=dark
if &background == "dark"
    set transp=8
endif

