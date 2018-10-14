#!/bin/sh
echo "==> Installing bin"

mkdir -p ~/.local/bin
cp -r ./* ~/.local/bin

rm ~/.local/bin/apply.sh
chmod +x ~/.local/bin/*

echo "==> Installed bin"
