#!/bin/sh
echo "==> Installing bin"

mkdir -p ~/.local/bin
cp -r ./* ~/.local/bin

rm ~/.local/bin/apply.sh
chmod +x ~/.local/bin/*


export GOPATH=~
export GOBIN=~/.local/bin
go get -u github.com/motemen/ghq
go get -u github.com/peco/peco/cmd/peco
go get -u github.com/rakyll/hey
go get -u github.com/alexanderGugel/wsd
go get -u github.com/jingweno/ccat
go get -u github.com/MaximeD/gost
go get -u github.com/dinedal/textql/textql
go get -u github.com/cortesi/modd/cmd/modd

echo "==> Installed bin"
