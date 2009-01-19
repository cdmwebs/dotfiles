" This must be first, because it changes other options as a side effect.
set nocompatible          " We're running Vim, not Vi!

" Syntax highlighting
" --------------------------
syntax on 					  " Enable syntax highlighting

if has('gui_running')
  colorscheme railscasts
else
  colorscheme desert
endif 

hi clear LineNr
highlight LineNr                    guifg=#666666   guibg=#1A1A1A

syntax sync fromstart
filetype plugin indent on

" Indentation and Tab handling
set smarttab
set expandtab
set autoindent
set shiftwidth=2 
set softtabstop=2 
set autoindent smartindent

" Line Wrapping
set nowrap
set linebreak                                     " Wrap at word

" Search results
set incsearch							" incremental searching
set hlsearch							" highlight search results
set ignorecase						" case insensitive searching
map <Space> :set hlsearch!<cr>

" Cursor (crosshairs)
"set cursorline
"set cursorcolumn

" Swapfiles
set nobackup
set noswapfile

" Split windows
set splitbelow
set splitright

set title
set ruler
set undolevels=100
set laststatus=2
set number ruler
set showmatch

filetype plugin indent on " Enable filetype-specific indenting and plugins

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

" Status line configuration (from tomasr)
" ---------------------------------------
set ls=2 " Always show status line
if has('statusline')
   " Status line detail:
   " %f    file path
   " %y    file type between braces (if defined)
   " %([%R%M]%)  read-only, modified and modifiable flags between braces
   " %{'!'[&ff=='default_file_format']}
   "      shows a '!' if the file format is not the platform
   "      default
   " %{'$'[!&list]}  shows a '*' if in list mode
   " %{'~'[&pm=='']}  shows a '~' if in patchmode
   " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
   "      only for debug : display the current syntax item name
   " %=    right-align following items
   " #%n    buffer number
   " %l/%L,%c%V  line number, total number of lines, and column number
   function SetStatusLineStyle()
      if &stl == '' || &stl =~ 'synID'
         let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n %l/%L,%c%V "
      else
         let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c%V "
      endif
   endfunc
   " Switch between the normal and vim-debug modes in the status line
   nmap _ds :call SetStatusLineStyle()<CR>
   call SetStatusLineStyle()
   " Window title
   if has('title')
   set titlestring=%t%(\ [%R%M]%)
   endif
endif
