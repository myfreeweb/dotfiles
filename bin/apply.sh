#!/bin/sh
echo "==> Installing bin"

mkdir -p ~/.local/bin
cp -r ./* ~/.local/bin

rm ~/.local/bin/apply.sh
chmod +x ~/.local/bin/*


export GOPATH=~
export GOBIN=~/.local/bin
go get -u github.com/motemen/ghq

echo "==> Installed bin"
