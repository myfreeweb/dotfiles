#!/bin/sh
echo "==> Installing tmux"

rm ~/.tmux.conf
cp tmux.conf ~/.tmux.conf

rm ~/.tmux-helper.sh
cp tmux-helper.sh ~/.tmux-helper.sh

echo "==> Installed tmux"
