#!/bin/sh
echo "==> Installing emacs"

mkdir -p ~/.emacs.d

rm ~/.emacs.d/Cask
cp Cask ~/.emacs.d/Cask

rm ~/.emacs.d/*.el
cp *.el ~/.emacs.d/

git clone https://github.com/cask/cask.git ~/.cask
~/.cask/bin/cask upgrade
cd ~/.emacs.d && ~/.cask/bin/cask install

rm ~/.emacs

echo "==> Installed emacs"
