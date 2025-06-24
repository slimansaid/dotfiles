" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Status bar
set laststatus=2

" Basic statusline configuration with spaces between elements
set statusline=%f\         " File name
set statusline+=%y\        " File type
set statusline+=%m\        " Modified flag
set statusline+=%r\        " Read-only flag
set statusline+=%=\        " Align right
set statusline+=%l/%L\     " Line number / Total lines
set statusline+=%p%%\      " Percentage through file
set statusline+=\ %c      " Column number

" Encoding.
set encoding=utf-8

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Add relative numbers to each line on the left-hand side.
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Highlight cursor line underneath the cursor vertically.
" set cursorcolumn

"The previous commands can be combined into a single line
set tabstop=2 shiftwidth=2 expandtab

" Set the commands to save in history default number is 20.
set history=1000

" Show color column at 80 characters width, visual reminder of keepingcode line within a popular line width.
" set colorcolumn=80

"Wraps text instead of forcing a horizontal scroll
set wrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest
