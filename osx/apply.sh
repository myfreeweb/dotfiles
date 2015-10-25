#!/bin/sh

echo "==> Installing osx"

./defaults.sh
./privacy.sh

mkdir -p ~/Library/KeyBindings
sed '$d' ./keybindings/DefaultKeyBinding.dict > ~/Library/KeyBindings/DefaultKeyBinding.dict

if [ -e "../x11/XCompose" ]; then
	export PERL_MB_OPT="--install_base \"$HOME/.local\""
	export PERL_MM_OPT="INSTALL_BASE=$HOME/.local"
	[[ ! -e "$HOME/.local/lib/perl5/X11/Keysyms.pm" ]] && cpan -f -i X11:Keysyms
	echo "\n  // XCompose " >> ~/Library/KeyBindings/DefaultKeyBinding.dict
	PERL5LIB="$HOME/.local/lib/perl5" perl ./compose2keybindings.pl < ../x11/XCompose | sed -e "s/\\\\UF710/^$\\\\UF710/" | tail -n +2 >> ~/Library/KeyBindings/DefaultKeyBinding.dict
else
	echo "==> Warning: x11 not found, not adding XCompose to DefaultKeyBinding"
	echo "}" >> ~/Library/KeyBindings/DefaultKeyBinding.dict
fi

cat ./amethyst.json > ~/.amethyst


SEIL="/Applications/Seil.app/Contents/Library/bin/seil"
if [[ -e "$SEIL" ]]; then
	$SEIL set enable_control_l 1
	$SEIL set enable_control_r 1
	$SEIL set enable_command_l 1
	$SEIL set enable_command_r 1
	$SEIL set enable_option_l 1
	$SEIL set enable_option_r 1

	# Hyper (sends F19, Karabiner turns that into Cmd+Opt+Ctrl+Shift)
	$SEIL set keycode_control_l 80
	$SEIL set keycode_control_r 80

	if [[ -z "$PCKEYBOARD" ]]; then
		echo "==> osx: Mac keyboard"
		# Cmd is Cmd, Opt is Opt -- reset in case of accidental PCKEYBOARD=1 execution or switching back
		$SEIL set keycode_command_l 55
		$SEIL set keycode_option_l 58
		$SEIL set keycode_command_r 54
		$SEIL set keycode_option_r 61
	else
		echo "==> osx: PC keyboard"
		# Swap Cmd and Opt for ANSI PC keyboard
		$SEIL set keycode_command_l 58
		$SEIL set keycode_option_l 55
		$SEIL set keycode_command_r 61
		$SEIL set keycode_option_r 54
	fi
else
	echo "==> Warning: Seil.app not found < https://pqrs.org/osx/karabiner/seil.html >"
fi


mkdir -p "$HOME/Library/Application Support/Karabiner"
cat ./private.xml > "$HOME/Library/Application Support/Karabiner/private.xml"

KARABINER="/Applications/Karabiner.app/Contents/Library/bin/karabiner"
if [[ -e "$KARABINER" ]]; then
	$KARABINER reloadxml
	$KARABINER set parameter.keyoverlaidmodifier_timeout 300
	$KARABINER set remap.controlL2controlL_escape 1
	$KARABINER set space_cadet.left_control_to_hyper 1
	$KARABINER set private.shifts_to_parens 1
	$KARABINER set private.send_shift_ctrl_f13_for_ropt 1
	$KARABINER set repeat.initial_wait 300
	$KARABINER set repeat.wait 40
else
	echo "==> Warning: Karabiner.app not found < https://pqrs.org/osx/karabiner/index.html.en >"
fi


echo "==> Installed osx"
