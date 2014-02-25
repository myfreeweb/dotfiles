#!/bin/sh
echo "==> Installing ruby"

rm $HOME/.irbrc
cp irbrc.rb $HOME/.irbrc

rm $HOME/.gemrc
cp gemrc $HOME/.gemrc

rm $HOME/.railsrc
cp railsrc $HOME/.railsrc

echo "==> Installed ruby"
