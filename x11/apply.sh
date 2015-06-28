#!/bin/sh
echo "==> Installing x11"

rm ~/.xinitrc
cp xinitrc ~/.xinitrc
touch ~/.xinitrc.local

rm ~/.Xresources
cp Xresources ~/.Xresources

mkdir -p ~/.config/bspwm
rm ~/.config/bspwm/bspwmrc
cp bspwmrc ~/.config/bspwm/bspwmrc
rm ~/.config/bspwm/bspwmbar
cp bspwmbar ~/.config/bspwm/bspwmbar

mkdir -p ~/.config/sxhkd
rm ~/.config/sxhkd/sxhkdrc
cp sxhkdrc ~/.config/sxhkd/sxhkdrc

pkill -USR1 -x sxhkd

rm ~/.xmobarrc
cp xmobar.hs ~/.xmobarrc

mkdir -p ~/.config/dunst
rm ~/.config/dunst/dunstrc
cp dunstrc.ini ~/.config/dunst/dunstrc

mkdir -p ~/.config/zathura
rm ~/.config/zathura/zathurarc
cp zathurarc ~/.config/zathura/zathurarc

rm ~/.gtkrc.mine
cp gtkrc.mine ~/.gtkrc.mine

rm ~/.gtkrc-1.2-gnome2
echo "include '$HOME/.gtkrc.mine'" > ~/.gtkrc-1.2-gnome2

rm ~/.gtkrc-2.0
echo "include '$HOME/.gtkrc.mine'" > ~/.gtkrc-2.0

mkdir -p ~/.config/gtk-3.0
rm ~/.config/gtk-3.0/settings.ini
rm ~/.config/gtk-3.0/gtk.css
cp gtk3.ini ~/.config/gtk-3.0/settings.ini
cp gtk3.css ~/.config/gtk-3.0/gtk.css

mkdir -p ~/.config/fontconfig
rm ~/.config/fontconfig/fonts.conf
cp fonts.xml ~/.config/fontconfig/fonts.conf

xrdb ~/.Xresources

echo "==> Installed x11"
