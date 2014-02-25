#!/bin/sh
echo "==> Installing dev-base"

rm ~/.gitconfig
cp gitconfig ~/.gitconfig

rm ~/.gitignore
cp gitignore ~/.gitignore

rm ~/.hgrc
cp hgrc ~/.hgrc

rm ~/.ackrc
cp ackrc ~/.ackrc

rm ~/.ctags
cp ctags ~/.ctags

rm ~/.curlrc
cp curlrc ~/.curlrc

mkdir -p ~/.gnupg
rm ~/.gnupg/gpg.conf
cp gpg.conf ~/.gnupg/gpg.conf

rm ~/.inputrc
cp inputrc ~/.inputrc

rm ~/.lesskey
cp lesskey ~/.lesskey

rm ~/.psqlrc
cp psqlrc ~/.psqlrc

rm ~/.rc
cp rc ~/.rc

mkdir -p ~/.ssh
rm ~/.ssh/config
cp ssh_config ~/.ssh/config

echo "==> Installed dev-base"
