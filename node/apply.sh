#!/bin/sh
echo "==> Installing node"

npm config set prefix ~/.local
npm config set cache ~/.cache/npm

echo "==> Installed node"
