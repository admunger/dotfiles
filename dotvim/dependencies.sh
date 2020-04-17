#!/bin/bash

# we copy locally to avoid running pathogen#infect each time at Vim opening
# less plugins is more

echo "creating bundle folder in Vim directory..."
mkdir ~/.vim/bundle
cd ~/.vim/bundle

# get directories
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/vim-scripts/taglist.vim.git
git clone https://github.com/preservim/nerdtree.git

# copy locally
mkdir -p ../plugin
cp vim-surround/plugin/* ../plugin/
cp taglist.vim/plugin/* ../plugin/

mkdir -p ../doc
cp vim-surround/doc/* ../doc/
cp taglist.vim/doc/* ../doc/

cd ~/.vim/
vim -c "helptags ./doc" -c q
