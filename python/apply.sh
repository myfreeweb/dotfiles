#!/bin/sh
echo "==> Installing python"

mkdir -p ~/.tmp
mkdir -p ~/.config/python
cat pythonrc.py > ~/.config/python/rc.py

echo "==> Installed python"
