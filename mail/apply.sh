#!/bin/sh
echo "==> Installing mail"

rm ~/.muttrc
cp muttrc ~/.muttrc

mkdir -p ~/.tmp/mutt/cache

rm ~/.notmuch-config
cat notmuch-config | sed -e "s|\$HOME|$HOME|" > ~/.notmuch-config

mkdir -p ~/bin
rm ~/bin/edit-and-hashcash
cp edit-and-hashcash.py ~/bin/edit-and-hashcash
chmod +x ~/bin/edit-and-hashcash

rm ~/.mail.ca.pem
cp mail.ca.pem ~/.mail.ca.pem

rm ~/.mailcap
if [ `uname` == "Darwin" ]; then
	cp osx.mailcap ~/.mailcap

	rm ~/.urlview
	cp osx.urlview ~/.urlview

	rm ~/.muttrc+osx
	cp muttrc+osx ~/.muttrc+osx

	rm ~/bin/view-attachment
	cp view-attachment.sh ~/bin/view-attachment
	chmod +x ~/bin/view-attachment

	rm ~/.msmtprc
	cp msmtprc ~/.msmtprc
	chmod 0600 ~/.msmtprc
else
	cp mailcap ~/.mailcap
fi

echo "==> Installed mail"
