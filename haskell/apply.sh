#!/bin/sh
echo "==> Installing haskell"

cat hirc > ~/.hirc

mkdir -p ~/.ghc
cat ghci.conf.hs > ~/.ghc/ghci.conf

mkdir -p ~/.cabal
sed "s#~#$HOME#" < config.cabal > ~/.cabal/config

echo "==> Installed haskell"
