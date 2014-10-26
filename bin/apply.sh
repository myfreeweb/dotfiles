#!/bin/sh

mkdir -p ~/bin
cp -r ./* ~/bin
chmod +x ~/bin/*
rm ~/bin/apply.sh

echo "==> Copied bin"
