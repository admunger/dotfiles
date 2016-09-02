execute pathogen#infect()

"General options for all files
set number
set relativenumber
set linebreak
set mouse=a
set splitright
set magic
vmap C "+y
set whichwrap+=<,>,[,]

"CSV parameters
"NewDelimiter ; "changes the delimiter
"let g:csv_delim=';'

"gvim configs
if has('gui_running')
    colorscheme pablo
else
    colorscheme munger
endif

"Code options
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set clipboard=unnamedplus
set cindent

"Options for search features
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set incsearch
set ignorecase
set smartcase

"Indentation for makefiles
"set noet ci pi sts=0 sw=4 ts=4

"Remap NERDTree command
:command NT NERDTree

"LaTex-related options
filetype plugin on
filetype indent on
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'


