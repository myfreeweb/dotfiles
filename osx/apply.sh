#!/bin/sh
echo "==> Installing osx"

mkdir -p /Library/KeyBindings
rm /Library/KeyBindings/DefaultKeyBinding.dict
cp ./keybindings/DefaultKeyBinding.dict /Library/KeyBindings/DefaultKeyBinding.dict

mkdir -p /Library/Application\ Support/KeyRemap4MacBook
rm /Library/Application\ Support/KeyRemap4MacBook/private.xml
cp ./private.xml /Library/Application\ Support/KeyRemap4MacBook/private.xml

rm /.slate.js
cat ./reslate/reslate.js ./slate.js > /.slate.js

./defaults.sh

echo "==> Installed osx"
