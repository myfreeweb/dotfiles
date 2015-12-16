#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# Thanks:
#  http://aaronlasseigne.com/2012/10/15/battery-life-in-the-land-of-tmux/

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

	battery) if [ "$(uname)" = "FreeBSD" ]; then
		BATTERIES="$(let "$(sysctl hw.acpi.battery.units | grep -Eo "[0-9]+") - 1")"
		if [ "$BATTERIES" != "0" ]; then
			for i in $(seq 0 $BATTERIES); do
				CHARGE="$(acpiconf -i $i | grep -Eo "[0-9]+%" | sed -e s/%//)"
				CHARGED_SLOTS="$(let "$CHARGE / 20")"
				UNCHARGED_SLOTS="$(let "5 - $CHARGED_SLOTS")"
				if [ "$CHARGED_SLOTS" != "0" ]; then
					printf '%s' '#[fg=red]'
					for j in $(seq 1 $CHARGED_SLOTS); do printf '%s' '♥'; done
				fi
				if [ "$UNCHARGED_SLOTS" != "0" ]; then
					printf '%s' '#[fg=white]'
					for j in $(seq 1 "$UNCHARGED_SLOTS"); do printf '%s' '♥'; done
				fi
				printf ' '
			done
		fi
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
