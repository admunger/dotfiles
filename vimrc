execute pathogen#infect()

"Option to remove any traces in .viminfo
set viminfo='0,:0,<0,@0,f0
"            |  |  |  |  '-file marks 0-9,A-Z not saved               
"            |  |  |  '-input-line history not saved
"            |  |  '-registers not saved
"            |  '-command-line history not saved
"            '-file marks not saved
"        no % : buffer list not saved
"        no / : search history will be saved

"General options for all files
"ruler options
set ruler
set number
set relativenumber
set linebreak "backspace support
set wildmenu
set mouse=a
" split configs
set splitright
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>w
nnoremap <C-L> <C-W>l

set magic
vmap C "+y
set whichwrap+=<,>,[,]

"gvim configs
if has('gui_running')
    colorscheme gurunew
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
else
    colorscheme munger "elflord
endif
if &diff
    colorscheme valloric
endif

"Code options
set tabstop=4
set shiftwidth=4
"set smarttab
set expandtab
set clipboard=unnamedplus
set cindent  "indent like C code

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
set modeline
filetype plugin on
syntax on
filetype indent on
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

let g:tex_flavor='latex'


"CSV parameters
" NewDelimiter ; "changes the delimiter
" let g:csv_delim=';'

"statusline options
set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=\ %{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=\ %{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

inoremap <C-s> <C-o>:update<CR>
