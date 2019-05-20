#!/bin/sh
echo "==> Installing x11"

mkdir -p ~/.local/bin

install_bin() {
	cat "$1" > "$HOME/.local/bin/$1"
	chmod +x "$HOME/.local/bin/$1"
}

install_bin2() {
	cat "$1" > "$HOME/.local/bin/$2"
	chmod +x "$HOME/.local/bin/$2"
}

install_bin floatyoutube
install_bin freepass-x11
install_bin x-terminal-emulator
install_bin bar.rs
install_bin2 volumectl.rs volumectl

cat xinitrc > ~/.xinitrc
touch ~/.xinitrc.local

touch ~/.Xresources.local
cat Xresources > ~/.Xresources

mkdir -p ~/.config/i3
cat i3.conf > ~/.config/i3/config

mkdir -p ~/.config/sway
cat sway.conf > ~/.config/sway/config
touch ~/.config/sway/local.conf

mkdir -p ~/.config/dunst
cat dunstrc.ini > ~/.config/dunst/dunstrc

cat compton.conf > ~/.config/compton.conf

cat evscript.dyon > ~/.config/evscript.dyon

xrdb ~/.Xresources

echo "==> Installed x11"
