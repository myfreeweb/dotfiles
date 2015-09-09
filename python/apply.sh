#!/bin/sh
echo "==> Installing python"

mkdir -p ~/.tmp
mkdir -p ~/.config/python
rm ~/.config/python/rc.py
cp pythonrc.py ~/.config/python/rc.py

echo "==> Installed python"
