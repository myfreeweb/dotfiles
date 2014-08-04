#!/bin/sh

PROFILES="$HOME/Library/Application Support/Firefox/Profiles"
DEFAULT_PROFILE="$PROFILES/`ls "$PROFILES" | grep "default$" | head -n 1`"
USERCHROME="$DEFAULT_PROFILE/chrome/userChrome.css"

if [[ -d "$DEFAULT_PROFILE" ]]; then
	echo "==> Installing firefox"
	mkdir -p "$DEFAULT_PROFILE/chrome"
	rm "$USERCHROME"
	cp ./userChrome.css "$USERCHROME"
	echo "==> Installed firefox"
else
	echo "==> Firefox not supported on this platform"
fi
