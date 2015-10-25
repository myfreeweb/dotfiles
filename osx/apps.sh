#!/bin/sh
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice

if [[ ! -e "`which brew`" ]]; then
	echo "Homebrew is required: http://brew.sh"
	exit 1
fi

brew tap caskroom/cask
brew tap caskroom/fonts
brew tap caskroom/versions

brew update

brew cask install karabiner seil amethyst gpgtools iterm2-nightly java java7 \
	google-chrome google-chrome-canary firefox firefoxdeveloperedition firefox-nightly \
	flux alfred dropbox virtualbox transmission vlc clarify forklift android-file-transfer fliqlo evernote skitch skype istat-menus imageoptim \
	qlcolorcode qlmarkdown qlprettypatch qlimagesize webpquicklook colorpicker-developer colorpicker-hex \
	font-fira-sans font-fantasque-sans-mono font-input font-signika font-open-sans font-source-sans-pro font-source-code-pro font-source-serif-pro \
	font-inconsolata-for-powerline font-comic-neue font-redacted font-londrina-outline font-londrina-shadow font-londrina-sketch font-londrina-solid \
	font-league-gothic font-kaushan-script font-amaranth font-averia-libre font-averia-gruesa-libre font-averia-sans-libre font-averia-serif-libre
