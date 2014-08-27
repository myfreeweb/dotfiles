#!/bin/sh
echo "==> Installing osx"

mkdir -p $HOME/Library/KeyBindings
rm $HOME/Library/KeyBindings/DefaultKeyBinding.dict
cp ./keybindings/DefaultKeyBinding.dict $HOME/Library/KeyBindings/DefaultKeyBinding.dict

rm $HOME/.slate.js
cat ./reslate/reslate.js ./slate.js > $HOME/.slate.js

./defaults.sh

SEIL=/Applications/Seil.app/Contents/Library/bin/seil
if [ -e $SEIL ]; then
	$SEIL set enable_control_l 1
	$SEIL set keycode_control_l 80
else
	echo "==> Warning: Seil.app not found < https://pqrs.org/osx/karabiner/seil.html >"
fi

mkdir -p $HOME/Library/Application\ Support/Karabiner
rm $HOME/Library/Application\ Support/Karabiner/private.xml
cp ./private.xml $HOME/Library/Application\ Support/Karabiner/private.xml

KARABINER=/Applications/Karabiner.app/Contents/Library/bin/karabiner
if [ -e $KARABINER ]; then
	$KARABINER reloadxml
	$KARABINER set remap.russian_backquote2paragraph 1
	$KARABINER set parameter.keyoverlaidmodifier_timeout 300
	$KARABINER set remap.controlL2controlL_escape 1
	$KARABINER set space_cadet.left_control_to_hyper 1
	$KARABINER set remap.russian_paragraph2backquote 1
	$KARABINER set private.shifts_to_parens 1
else
	echo "==> Warning: Karabiner.app not found < https://pqrs.org/osx/karabiner/index.html.en >"
fi

echo "==> Installed osx"
