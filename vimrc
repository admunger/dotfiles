execute pathogen#infect()

set number
set relativenumber
set linebreak
set mouse=a
vmap C "+y

if has('gui_running')
    colorscheme pablo
else
    colorscheme peachpuff
endif

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set clipboard=unnamedplus

"For the search features
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set incsearch
set ignorecase
set smartcase

"Indentation for makefiles
"set noet ci pi sts=0 sw=4 ts=4

"Remap NERDTree command
:command NE NERDTree

