#!/usr/bin/env zsh

if [[ $1 == "" ]]; then
	echo "Usage: $0 ssh-address module (module module ...)"
	exit 2
fi

server=$1

for module in "$@"; do
	if [[ -d "$module" ]]; then
		if [[ -f "$module/apply.sh" ]]; then
			echo "=> Sending $module"
			find "$module" -depth -print | cpio -o | ssh "$server" 'cpio -id'
			ssh "$server" "cd $module && sh apply.sh && cd .. && rm -r $module"
		else
			echo "=> $module is not a module"
		fi
	elif [[ "$module" != "$server" ]]; then
		echo "=> $module is not even a directory"
	fi
done
