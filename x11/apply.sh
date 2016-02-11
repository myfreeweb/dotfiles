#!/bin/sh
echo "==> Installing x11"

mkdir -p ~/.local/bin

install_bin() {
	cat "$1" > "$HOME/.local/bin/$1"
	chmod +x "$HOME/.local/bin/$1"
}

install_bin brightctl
install_bin floatyoutube
install_bin mkscreencast
install_bin mkscreenshot
install_bin freepass-x11
install_bin multi-monitor
install_bin volumectl
install_bin x-terminal-emulator

cat xinitrc > ~/.xinitrc
touch ~/.xinitrc.local

cat Xresources > ~/.Xresources

cat XCompose > ~/.XCompose

mkdir -p ~/.config/bspwm
cat bspwmrc  > ~/.config/bspwm/bspwmrc
chmod +x ~/.config/bspwm/bspwmrc

mkdir -p ~/.config/sxhkd
cat sxhkdrc > ~/.config/sxhkd/sxhkdrc

mkdir -p ~/.config/tint2
cat tint2rc > ~/.config/tint2/tint2rc

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
