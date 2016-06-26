#!/bin/sh
echo "==> Installing hexchat"

mkdir -p "$HOME/.config/hexchat/addons"

install_plugin() {
	cat "$1" > "$HOME/.config/hexchat/addons/$1"
}

install_plugin crawlcolor.py

echo "==> Installed hexchat"
