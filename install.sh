#!/bin/sh

if [ "$1" == "" ]; then
	echo "Usage: $0 module (module module ...)"
	exit 2
fi


for module in "$@"; do
	if [ -d "$module" ]; then
		if [ -f "$module/apply.sh" ]; then
			cd "$module" && sh apply.sh && cd .. 
		else
			echo "=> $module is not a module, where is $module/apply.sh ?!"
		fi
	else
		echo "=> $module is not even a directory"
	fi
done
