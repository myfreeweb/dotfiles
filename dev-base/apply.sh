#!/bin/sh
echo "==> Installing dev-base"

rm /.gitconfig
cp gitconfig /.gitconfig

rm /.gitignore
cp gitignore /.gitignore

rm /.hgrc
cp hgrc /.hgrc

rm /.ackrc
cp ackrc /.ackrc

rm /.ctags
cp ctags /.ctags

echo "==> Installed dev-base"
