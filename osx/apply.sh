#!/bin/sh
echo "==> Installing osx"
mkdir -p $HOME/Library/KeyBindings
rm $HOME/Library/KeyBindings/DefaultKeyBinding.dict
cp ./keybindings/DefaultKeyBinding.dict $HOME/Library/KeyBindings/DefaultKeyBinding.dict
mkdir -p $HOME/Library/Application\ Support/KeyRemap4MacBook
rm $HOME/Library/Application\ Support/KeyRemap4MacBook/private.xml
cp ./private.xml $HOME/Library/Application\ Support/KeyRemap4MacBook/private.xml
rm $HOME/.slate.js
cat ./reslate/reslate.js ./slate.js > $HOME/.slate.js
./defaults.sh
echo "==> Installed osx"
