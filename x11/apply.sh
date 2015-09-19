#!/bin/sh
echo "==> Installing x11"

cat xinitrc > ~/.xinitrc
touch ~/.xinitrc.local

cat Xresources > ~/.Xresources

cat Xcompose > ~/.Xcompose

mkdir -p ~/.config/bspwm
cat bspwmrc  > ~/.config/bspwm/bspwmrc
cat bspwmbar > ~/.config/bspwm/bspwmbar

mkdir -p ~/.config/sxhkd
cat sxhkdrc > ~/.config/sxhkd/sxhkdrc

pkill -USR1 -x sxhkd

cat xmobar.hs > ~/.xmobarrc

mkdir -p ~/.config/dunst
cat dunstrc.ini > ~/.config/dunst/dunstrc

mkdir -p ~/.config/zathura
cat zathurarc > ~/.config/zathura/zathurarc

cat gtkrc.mine > ~/.gtkrc.mine

echo "include '$HOME/.gtkrc.mine'" > ~/.gtkrc-1.2-gnome2

echo "include '$HOME/.gtkrc.mine'" > ~/.gtkrc-2.0

mkdir -p ~/.config/gtk-3.0
cat gtk3.ini > ~/.config/gtk-3.0/settings.ini
cat gtk3.css > ~/.config/gtk-3.0/gtk.css

mkdir -p ~/.config/fontconfig
cat fonts.xml > ~/.config/fontconfig/fonts.conf

xrdb ~/.Xresources

echo "==> Installed x11"
