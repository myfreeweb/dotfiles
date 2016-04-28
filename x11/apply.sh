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

install_bin brightctl
install_bin floatyoutube
install_bin mkscreencast
install_bin mkscreenshot
install_bin freepass-x11
install_bin multi-monitor
install_bin x-terminal-emulator
install_bin bar.rs
install_bin2 volumectl.rs volumectl

cat xinitrc > ~/.xinitrc
touch ~/.xinitrc.local

cat Xresources > ~/.Xresources

cat XCompose > ~/.XCompose

mkdir -p ~/.config/i3
cat i3.conf > ~/.config/i3/config

mkdir -p ~/.config/sxhkd
cat sxhkdrc > ~/.config/sxhkd/sxhkdrc

pkill -USR1 -x sxhkd

mkdir -p ~/.config/dunst
cat dunstrc.ini > ~/.config/dunst/dunstrc

mkdir -p ~/.config/zathura
cat zathurarc > ~/.config/zathura/zathurarc

mkdir -p ~/.config/gtk-2.0
cat gtkrc.mine > ~/.config/gtk-2.0/gtkrc

mkdir -p ~/.config/gtk-3.0
cat gtk3.ini > ~/.config/gtk-3.0/settings.ini
cat gtk3.css > ~/.config/gtk-3.0/gtk.css

mkdir -p ~/.config/fontconfig
cat fonts.xml > ~/.config/fontconfig/fonts.conf

xrdb ~/.Xresources

echo "==> Installed x11"
