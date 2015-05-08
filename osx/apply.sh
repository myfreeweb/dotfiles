#!/usr/bin/env zsh
echo "==> Installing osx"

mkdir -p ~/Library/KeyBindings
rm ~/Library/KeyBindings/DefaultKeyBinding.dict
cp ./keybindings/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

rm ~/.amethyst
cp ./amethyst.json ~/.amethyst

./defaults.sh

SEIL=/Applications/Seil.app/Contents/Library/bin/seil
if [ -e "$SEIL" ]; then
	# Hyper (sends F19, Karabiner turns that into Cmd+Opt+Ctrl+Shift)
	$SEIL set enable_control_l 1
	$SEIL set keycode_control_l 80
	$SEIL set enable_control_r 1
	$SEIL set keycode_control_r 80
	if [ -z "$PCKEYBOARD" ]; then
		echo "==> osx: Mac keyboard"
		# Cmd is Cmd, Opt is Opt -- reset in case of accidental PCKEYBOARD=1 execution or switching back
		$SEIL set enable_command_l 1
		$SEIL set keycode_command_l 55
		$SEIL set enable_option_l 1
		$SEIL set keycode_option_l 58
		$SEIL set enable_command_r 1
		$SEIL set keycode_command_r 54
		$SEIL set enable_option_r 1
		$SEIL set keycode_option_r 61
	else
		echo "==> osx: PC keyboard"
		# Swap Cmd and Opt for ANSI PC keyboard
		$SEIL set enable_command_l 1
		$SEIL set keycode_command_l 58
		$SEIL set enable_option_l 1
		$SEIL set keycode_option_l 55
		$SEIL set enable_command_r 1
		$SEIL set keycode_command_r 61
		$SEIL set enable_option_r 1
		$SEIL set keycode_option_r 54
	fi
else
	echo "==> Warning: Seil.app not found < https://pqrs.org/osx/karabiner/seil.html >"
fi

mkdir -p "$HOME/Library/Application Support/Karabiner"
rm "$HOME/Library/Application Support/Karabiner/private.xml"
cp ./private.xml "$HOME/Library/Application Support/Karabiner/private.xml"

KARABINER=/Applications/Karabiner.app/Contents/Library/bin/karabiner
if [ -e "$KARABINER" ]; then
	$KARABINER reloadxml
	$KARABINER set parameter.keyoverlaidmodifier_timeout 300
	$KARABINER set remap.controlL2controlL_escape 1
	$KARABINER set space_cadet.left_control_to_hyper 1
	$KARABINER set private.shifts_to_parens 1
else
	echo "==> Warning: Karabiner.app not found < https://pqrs.org/osx/karabiner/index.html.en >"
fi

echo "==> Installed osx"
