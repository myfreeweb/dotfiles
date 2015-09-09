#!/bin/sh

mkdir -p ~/.local/bin
cp -r ./* ~/.local/bin
chmod +x ~/.local/bin/*
rm ~/.local/bin/apply.sh

echo "==> Copied bin"
