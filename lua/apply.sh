#!/bin/sh
echo "==> Installing lua"

mkdir -p ~/.luarocks
rm ~/.luarocks/config.lua
cp luarocks.config.lua ~/.luarocks/config.lua

echo "==> Installed lua"
