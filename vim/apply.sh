#!/bin/sh
echo "==> Installing vim"

mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backups
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

rm ~/.vimrc
cp vimrc ~/.vimrc

rm ~/.nvimrc
cp vimrc ~/.nvimrc

rm ~/.vim/*.vim
cp ./*.vim ~/.vim/

rm ~/.nvim
ln -s "$HOME/.vim" "$HOME/.nvim"

rm -r ~/.vim/ftplugin
cp -r ftplugin ~/.vim/ftplugin

rm -r ~/.vim/syntax
cp -r syntax ~/.vim/syntax

vim +PlugClean! +PlugUpdate +qall

echo "==> Installed vim"
