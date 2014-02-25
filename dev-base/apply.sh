#!/bin/sh
echo "==> Installing dev-base"

rm $HOME/.gitconfig
cp gitconfig $HOME/.gitconfig

rm $HOME/.gitignore
cp gitignore $HOME/.gitignore

rm $HOME/.hgrc
cp hgrc $HOME/.hgrc

rm $HOME/.ackrc
cp ackrc $HOME/.ackrc

rm $HOME/.ctags
cp ctags $HOME/.ctags

echo "==> Installed dev-base"
