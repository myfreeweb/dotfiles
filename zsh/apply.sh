#!/bin/sh
echo "==> Installing zsh"

mkdir -p ~/.tmp
mkdir -p ~/.tmp/tmux
mkdir -p ~/.zsh
mkdir -p ~/.config/base16

rm -r ~/.zsh/zshuery

rm -r ~/.zsh/zsh-hl
cp -r zsh-hl ~/.zsh/zsh-hl

rm -r ~/.zsh/zsh-hss
cp -r zsh-hss ~/.zsh/zsh-hss

rm -r ~/.zsh/zsh-completions
cp -r zsh-completions ~/.zsh/zsh-completions

rm -r ~/.zsh/base16-shell
cp -r base16-shell ~/.zsh/base16-shell

rm ~/.zshrc
cp zshrc ~/.zshrc

echo "==> Installed zsh"
