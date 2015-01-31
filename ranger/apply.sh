#!/bin/sh
echo "==> Installing ranger"

mkdir -p ~/.config/ranger

rm ~/.config/ranger/commands.py
cp commands.py ~/.config/ranger/commands.py

rm ~/.config/ranger/rc.conf
cp rc.conf ~/.config/ranger/rc.conf

rm ~/.config/ranger/rifle.conf
cp rifle.conf ~/.config/ranger/rifle.conf

echo "==> Installed ranger"
