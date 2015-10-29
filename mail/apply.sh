#!/bin/sh
echo "==> Installing mail"

cat muttrc > ~/.muttrc

mkdir -p ~/.tmp/mutt/cache

cat notmuch-config | sed -e "s|\$HOME|$HOME|" > ~/.notmuch-config

mkdir -p ~/.local/bin
cat edit-and-hashcash.py > ~/.local/bin/edit-and-hashcash
chmod +x ~/.local/bin/edit-and-hashcash

cat mail.ca.pem > ~/.mail.ca.pem

cat msmtprc > ~/.msmtprc
chmod 0600 ~/.msmtprc

if [ "$(uname)" = "Darwin" ]; then
	cat osx.mailcap > ~/.mailcap

	echo "COMMAND open %s" > ~/.urlview

	cat muttrc+osx > ~/.muttrc+osx

	cat view-attachment.sh > ~/bin/view-attachment
	chmod +x ~/bin/view-attachment
else
	cat mailcap > ~/.mailcap

	echo "COMMAND xdg-open %s" > ~/.urlview
fi

echo "==> Installed mail"
