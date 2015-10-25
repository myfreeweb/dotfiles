#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

if [[ ! -e "`which brew`" ]]; then
	echo "Homebrew is required: http://brew.sh"
	exit 1
fi

brew tap homebrew/dupes
brew tap homebrew/binary
brew tap homebrew/versions
brew tap homebrew/x11

brew update

brew install ca_root_nss libressl w3m curl wget \
	reattach-to-user-namespace zsh tmux less tree ncdu toilet jq ranger bsdmake curl wget signify-osx \
	ack ctags git mercurial bzr vim sloccount go node \
	msmtp contacts urlview hashcash notmuch
brew install mutt --with-trash-patch --with-gpgme
brew install openssh --with-ldns
