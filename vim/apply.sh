#!/bin/sh
echo "==> Installing vim"

mkdir -p ~/.vim/tmp
mkdir -p ~/.vim/tmp/undo
mkdir -p ~/.vim/tmp/backups
mkdir -p ~/.vim/bundle

if [ -d "$HOME/.vim/bundle/vundle" ]; then
	(cd ~/.vim/bundle/vundle && git pull)
else
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

rm ~/.vimrc
cp vimrc ~/.vimrc

rm ~/.nvimrc
cp vimrc ~/.nvimrc

rm ~/.vim/*.vim
cp *.vim ~/.vim/

rm ~/.nvim
ln -s $HOME/.vim $HOME/.nvim

rm -r ~/.vim/ftplugin
cp -r ftplugin ~/.vim/ftplugin

rm -r ~/.vim/syntax
cp -r syntax ~/.vim/syntax

vim +PluginClean +PluginInstall +qall

echo "==> Installed vim"
