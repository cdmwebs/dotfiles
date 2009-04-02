" This must be first, because it changes other options as a side effect.
set nocompatible          " We're running Vim, not Vi!

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" keep more history
set history=100

" Syntax highlighting
" --------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  syntax sync fromstart
  set hlsearch
  colorscheme desert
endif

" map leader to comma
let mapleader = ","

" where am i?
set cursorline

" Indentation and Tab handling
set smarttab
set expandtab
set autoindent
set shiftwidth=2 
set tabstop=2 
set autoindent smartindent

" Line Wrapping
set nowrap
set linebreak                                     " Wrap at word

" Search results
set incsearch							" incremental searching
set ignorecase						" case insensitive searching
set smartcase

" Toggle search results with spacebar
map <Space> :set hlsearch!<cr>

" Don't use Ex mode, use Q for formatting
map Q gq

" Cursor (crosshairs)
"set cursorline
"set cursorcolumn

" Swapfiles. Fuck 'em.
set nobackup
set noswapfile
set nowritebackup

" show incomplete commands
set showcmd

" Split windows behavior
set splitbelow
set splitright

" chill the press ENTER or type command to continue stuff
set shortmess=atI

set ruler
set undolevels=100
" turning off line numbers for now
"set number
set showmatch

" Only do this part when compiled with support for autocommands.
if has("autocmd")
 
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
 
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
 
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
 
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif
 
  augroup END
else
  set autoindent    " always set autoindenting on
endif " has("autocmd")

if has("folding")
  set foldenable
  set foldmethod=syntax
  set foldlevel=1
  set foldnestmax=2
  set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
 
  " automatically open folds at the starting cursor position
  " autocmd BufReadPost .foldo!
endif

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
set laststatus=2 " Always show status line
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
