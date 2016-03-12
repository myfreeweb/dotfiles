#!/bin/sh
while true; do
	cargo script ~/.local/bin/bar.rs | lemonbar -B "#DD222222" -f "Fira Mono:size=10" -f "FontAwesome:size=11" | sh
	sleep 1
done
