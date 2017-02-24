#!/bin/sh
echo "==> Installing haskell"

mkdir -p ~/.ghc
cat ghci.conf.hs > ~/.ghc/ghci.conf

mkdir -p ~/.cabal
sed "s#~#$HOME#" < config.cabal > ~/.cabal/config

mkdir -p ~/.stack
cat stack.yaml > ~/.stack/config.yaml

echo "==> Installed haskell"
