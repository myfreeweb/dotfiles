#!/bin/sh
echo "==> Installing lein"

mkdir -p ~/.lein

rm ~/.lein/init.clj
cp init.clj ~/.lein/init.clj

rm ~/.lein/profiles.clj
cp profiles.clj ~/.lein/profiles.clj

echo "==> Installed lein"
