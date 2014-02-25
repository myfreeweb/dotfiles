#!/bin/sh
echo "==> Installing tmux"

rm $HOME/.tmux.conf
cp tmux.conf $HOME/.tmux.conf

rm $HOME/.tmux-helper.sh
cp tmux-helper.sh $HOME/.tmux-helper.sh

echo "==> Installed tmux"
