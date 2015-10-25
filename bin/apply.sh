#!/bin/sh
echo "==> Installing bin"

mkdir -p ~/.local/bin
cp -r ./* ~/.local/bin

rm ~/.local/bin/apply.sh
chmod +x ~/.local/bin/*


GOPATH=~
GOBIN=~/.local/bin
go get github.com/motemen/ghq
go get github.com/peco/peco/cmd/peco
go get github.com/monochromegane/the_platinum_searcher/cmd/pt

echo "==> Installed bin"
