#!/bin/sh
echo "==> Installing dev-base"

mkdir -p ~/.tmp

cat gitconfig > ~/.gitconfig

cat gitignore > ~/.gitignore

cat hgrc > ~/.hgrc

sed -e "s/^#.*$//" < ctags > ~/.ctags

cat curlrc > ~/.curlrc

mkdir -p ~/.gnupg
cat gpg.conf > ~/.gnupg/gpg.conf

cat inputrc > ~/.inputrc

cat lesskey > ~/.lesskey
lesskey

cat psqlrc > ~/.psqlrc

cat rc > ~/.rc

mkdir -p ~/.ssh
cat ssh_config > ~/.ssh/config
if [ -r /usr/local/lib/libsimple-tpm-pk11.so ]; then
	sed -I "" -e "s/# PKCS11Provider/PKCS11Provider/" ~/.ssh/config
fi

mkdir -p ~/.config/peco
cat peco.json > ~/.config/peco/config.json

echo "==> Installed dev-base"
