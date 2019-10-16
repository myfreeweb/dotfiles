#!/bin/sh
echo "==> Installing dev-base"

mkdir -p ~/.tmp

cat gitconfig > ~/.gitconfig

cat gitignore > ~/.gitignore

cat hgrc > ~/.hgrc

sed -e "s/^#.*$//" < ctags > ~/.ctags

cat curlrc > ~/.curlrc

cat inputrc > ~/.inputrc

cat lesskey > ~/.lesskey
lesskey

cat psqlrc > ~/.psqlrc

cat rc > ~/.rc

mkdir -p ~/.ssh
cat ssh_config > ~/.ssh/config

echo "==> Installed dev-base"
