#!/bin/sh
echo "==> Installing ruby"

cat irbrc.rb > ~/.irbrc
cat gemrc > ~/.gemrc
cat railsrc > ~/.railsrc

echo "==> Installed ruby"
