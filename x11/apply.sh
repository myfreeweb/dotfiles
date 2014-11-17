#!/bin/sh
echo "==> Installing x11"

rm ~/.xinitrc
cp xinitrc ~/.xinitrc

rm -r ~/.base16-xresources
cp -r base16-xresources ~/.base16-xresources

rm ~/.Xresources
cat Xresources | sed -e "s|%home%|$HOME|" > ~/.Xresources
xrdb ~/.Xresources

mkdir -p ~/.xmonad
rm ~/.xmonad/xmonad.hs
cp xmonad.hs ~/.xmonad/xmonad.hs
xmonad --recompile

rm ~/.xmobarrc
cp xmobar.hs ~/.xmobarrc

rm ~/.gtkrc.mine
cp gtkrc.mine ~/.gtkrc.mine

rm ~/.gtkrc-2.0
echo "include '$HOME/.gtkrc.mine'" > ~/.gtkrc-2.0

rm ~/.gtkrc-1.2-gnome2
echo "include '$HOME/.gtkrc.mine'" > ~/.gtkrc-1.2-gnome2

echo "==> Installed x11"
