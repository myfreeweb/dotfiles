#!/bin/sh
echo "==> Installing ruby"

rm ~/.irbrc
cp irbrc.rb ~/.irbrc

rm ~/.gemrc
cp gemrc ~/.gemrc

rm ~/.railsrc
cp railsrc ~/.railsrc

echo "==> Installed ruby"
