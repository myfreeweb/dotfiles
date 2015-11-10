#!/bin/sh
echo "==> Installing lein"

mkdir -p ~/.lein

rm ~/.lein/profiles.clj
cp profiles.clj ~/.lein/profiles.clj

echo "==> Installed lein"
