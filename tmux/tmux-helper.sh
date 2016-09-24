#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

MAIL_INBOX="$HOME/Mail/INBOX/new"

case "$1" in
	launch-shell)
		if [ "$(uname)" = "Darwin" ]; then
			if [ -x "$(which reattach-to-user-namespace)" ]; then
				exec reattach-to-user-namespace -l "$2"
			else
				echo "install reattach-to-user-namespace!"
				exec "$2"
			fi
		else
			exec "$2"
		fi ;;

	top) if [ -x "$(which htop)" ]; then exec htop; else exec top; fi ;;

	mail) if [ -d "$MAIL_INBOX" ]; then
			MAIL_COUNT="$(ls "$MAIL_INBOX" | wc -l | sed -e 's/^[ \t]*//')"
			[ "$MAIL_COUNT" != "0" ] && printf " ✉ %s " "$MAIL_COUNT"
		fi ;;

	copy-buf) if [ -x "$(which reattach-to-user-namespace)" ] && [ -x "$(which pbcopy)" ]; then
		tmux save-buffer - | reattach-to-user-namespace pbcopy
	elif [ -x "$(which xclip)" ]; then
		tmux save-buffer - | xclip
	else
		echo "Copy not supported"
	fi ;;

	copy-pipe) if [ -x "$(which reattach-to-user-namespace)" ] && [ -x "$(which pbcopy)" ]; then
		exec reattach-to-user-namespace pbcopy
	elif [ -x "$(which xclip)" ]; then
		exec xclip
	else
		echo "Copy not supported"
	fi ;;

	*) echo "Unknown command";;
esac
