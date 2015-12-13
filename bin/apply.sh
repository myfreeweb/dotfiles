#!/bin/sh
echo "==> Installing bin"

mkdir -p ~/.local/bin
cp -r ./* ~/.local/bin

rm ~/.local/bin/apply.sh
chmod +x ~/.local/bin/*


export GOPATH=~
export GOBIN=~/.local/bin
go get github.com/motemen/ghq
go get github.com/peco/peco/cmd/peco
go get github.com/monochromegane/the_platinum_searcher/cmd/pt
go get github.com/rakyll/boom
go get github.com/schachmat/wego
go get github.com/alexanderGugel/wsd
go get github.com/jingweno/ccat
go get github.com/asciinema/asciinema
go get github.com/dinedal/textql/cmd && mv ~/.local/bin/cmd ~/.local/bin/textql
go get github.com/michaeldv/mop && mv ~/.local/bin/cmd ~/.local/bin/mop

echo "==> Installed bin"
