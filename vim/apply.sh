#!/bin/sh
echo "==> Installing vim"

mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backups
mkdir -p ~/.vim/bundle

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

rm ~/.vimrc
cp vimrc ~/.vimrc

rm ~/.gvimrc
cp gvimrc ~/.gvimrc

rm ~/.vim/*.vim
cp *.vim ~/.vim/

rm -r ~/.vim/ftplugin
cp -r ftplugin ~/.vim/ftplugin

rm -r ~/.vim/syntax
cp -r syntax ~/.vim/syntax

vim +BundleClean +BundleInstall +qall

echo "==> Installed vim"
