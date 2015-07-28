#!/bin/sh
echo "==> Installing haskell"

rm ~/.hirc
cp hirc ~/.hirc

mkdir -p ~/.ghc
rm ~/.ghc/ghci.conf
cp ghci.conf.hs ~/.ghc/ghci.conf

mkdir -p ~/.cabal
rm ~/.cabal/config
cat config.cabal | sed "s#~#$HOME#" > ~/.cabal/config

mkdir -p ~/.stack/
rm ~/.stack/stack.yaml
sed -e "s|~|$HOME|" < stack.yaml > ~/.stack/stack.yaml

echo "==> Installed haskell"
