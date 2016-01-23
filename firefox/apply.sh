#!/bin/sh

for prof in `find $HOME/.mozilla/firefox/ -name '*.default'`; do
	mkdir -p $prof/chrome
	cp userChrome.css $prof/chrome/userChrome.css
done
