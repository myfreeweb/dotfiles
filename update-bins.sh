#!/bin/sh

npm i -g \
	npm-check-updates publish-diff stackvis

cargo install cargo-update

cargo install-update -i \
	cargo-update cargo-script cargo-vendor cargo-outdated cargo-osha cargo-geiger \
	rusty-tags oxipng twiggy

stack install pandoc pandoc-citeproc
