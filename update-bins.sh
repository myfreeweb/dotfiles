#!/bin/sh

pip3.6 install --user --upgrade \
	pgcli sphinx sphinx-autobuild pygments python-language-server pyls-mypy neovim pipenv

gem install \
	language_server fastri

npm i -g \
	npm-check-updates publish-diff stackvis diff-so-fancy coap-cli

cargo install --force \
	cargo-script cargo-vendor cargo-outdated cargo-osha cargo-geiger \
	rusty-tags oxipng twiggy bingrep xsv

stack install pandoc pandoc-citeproc

export GOPATH=~
export GOBIN=~/.local/bin
go get -u github.com/motemen/ghq
