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
go get -u github.com/monochromegane/the_platinum_searcher/cmd/pt
go get -u github.com/pranavraja/tldr
go get -u github.com/rakyll/hey
go get -u github.com/schachmat/wego
go get -u github.com/alexanderGugel/wsd
go get -u github.com/jingweno/ccat
go get -u github.com/asciinema/asciinema
go get -u github.com/MaximeD/gost
go get -u github.com/dinedal/textql/textql
go get -u github.com/mop-tracker/mop/cmd && mv ~/.local/bin/cmd ~/.local/bin/mop
go get -u github.com/cortesi/devd/cmd/devd
go get -u github.com/cortesi/modd/cmd/modd

echo "==> Installed bin"
