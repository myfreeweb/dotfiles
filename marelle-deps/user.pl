% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

% Nice login welcome message
managed_pkg(archey).
managed_pkg(bsdinfo).
meta_pkg(welcome, freebsd, [bsdinfo]).
meta_pkg(welcome, osx, [archey]).
managed_pkg(cowsay).
command_pkg(fortune).
installs_with_brew(fortune).

% Internets
managed_pkg(curl).
managed_pkg(wget).
pkg(libressl).
installs_with_brew(libressl).
installs_with_ports(libressl, 'security/libressl').

% Mail
pkg(mutt).
depends(mutt, freebsd, [libressl]).
installs_with_brew(mutt, mutt, '--with-trash-patch --with-gpgme').
installs_with_ports(mutt, 'mail/mutt', 'WITH="FLOCK GPGME IDN SIDEBAR_PATCH TRASH_PATCH" WITHOUT="XML DOCS EXAMPLES"').
managed_pkg(msmtp).
managed_pkg(urlview).
meta_pkg(mail, [
	mutt, msmtp, urlview
]).

% Shell
managed_pkg(tmux).
managed_pkg(zsh).
managed_pkg(tree).
command_pkg(ghq).
installs_with_go(ghq, 'github.com/motemen/ghq').
command_pkg(peco).
installs_with_go(peco, 'github.com/peco/peco/cmd/peco').

meta_pkg(shell, [
	welcome, cowsay, fortune,
	curl, wget,
	tmux, zsh, tree, ghq, peco
]).

% Security
managed_pkg(keychain).
managed_pkg(rkhunter).

% OS X
managed_pkg('reattach-to-user-namespace') :- platform(osx).

cask_pkg(karabiner).
cask_pkg(seil).
cask_pkg(flux).

cask_pkg(mjolnir).
luarocks_pkg('mjolnir.hotkey').
luarocks_pkg('mjolnir.application').
luarocks_pkg('mjolnir.geometry').
luarocks_pkg('mjolnir.screen').
luarocks_pkg('mjolnir.keycodes').
luarocks_pkg('mjolnir.fnutils').
luarocks_pkg('mjolnir.cmsj.appfinder').
depends('mjolnir.cmsj.appfinder', _, ['mjolnir.fnutils']).
luarocks_pkg('mjolnir.bg.grid').
meta_pkg('mjolnir-configured', [
	'mjolnir', 'mjolnir.hotkey', 'mjolnir.application', 'mjolnir.geometry', 'mjolnir.screen', 'mjolnir.keycodes',
	'mjolnir.cmsj.appfinder', 'mjolnir.bg.grid'
]).

brew_tap('cask-versions-tap', 'caskroom/homebrew-versions').

cask_pkg(alfred).
cask_pkg(dropbox).
cask_pkg(virtualbox).
cask_pkg(transmission).
cask_pkg(cleanmymac).
cask_pkg(tunnelblick).
% cask_pkg(xquartz).
% cask_pkg(inkscape).
% depends(inkscape, osx, [xquartz]).
cask_pkg(vlc).
% cask_pkg(handbrake).
cask_pkg(clarify).
cask_pkg(forklift).
cask_pkg(gpgtools).
cask_pkg('android-file-transfer').
cask_pkg(fliqlo).
cask_pkg(evernote).
cask_pkg(skitch).
cask_pkg(skype).
cask_pkg('istat-menus').
cask_pkg(imageoptim).
cask_pkg(qlcolorcode).
cask_pkg(qlmarkdown).
cask_pkg(qlprettypatch).
cask_pkg(qlimagesize).
cask_pkg(qlstephen).
cask_pkg('colorpicker-developer').
cask_pkg('colorpicker-hex').
cask_pkg('iterm2-beta').
depends('iterm2-beta', _, ['cask-versions-tap']).
cask_pkg(java).
cask_pkg(java7).
cask_pkg('google-chrome').
cask_pkg('google-chrome-canary').
depends('google-chrome-canary', _, ['cask-versions-tap']).
cask_pkg('firefox').
% cask_pkg('firefox-aurora').
% depends('firefox-aurora', _, ['cask-versions-tap']).
cask_pkg('firefox-nightly').
depends('firefox-nightly', _, ['cask-versions-tap']).

brew_tap('cask-fonts-tap', 'caskroom/homebrew-fonts').
pkg(P) :- font_pkg(P).
installs_with_brew_cask(P) :- font_pkg(P).
depends(P, _, ['cask-fonts-tap']) :- font_pkg(P).

font_pkg('font-fira-sans').
font_pkg('font-signika').
font_pkg('font-open-sans').
font_pkg('font-source-sans-pro').
font_pkg('font-source-code-pro').
font_pkg('font-source-serif-pro').
font_pkg('font-inconsolata-for-powerline').
font_pkg('font-comic-neue').
font_pkg('font-redacted').
font_pkg('font-londrina-outline').
font_pkg('font-londrina-shadow').
font_pkg('font-londrina-sketch').
font_pkg('font-londrina-solid').
font_pkg('font-league-gothic').
font_pkg('font-kaushan-script').
font_pkg('font-amaranth').
font_pkg('font-averia-libre').
font_pkg('font-averia-gruesa-libre').
font_pkg('font-averia-sans-libre').
font_pkg('font-averia-serif-libre').

meta_pkg(fonts, [
	'font-fira-sans', 'font-signika', 'font-open-sans',
	'font-source-sans-pro', 'font-source-code-pro', 'font-source-serif-pro',
	'font-inconsolata-for-powerline', 'font-comic-neue', 'font-redacted',
	'font-londrina-outline', 'font-londrina-shadow', 'font-londrina-sketch', 'font-londrina-solid',
	'font-league-gothic', 'font-kaushan-script', 'font-amaranth',
	'font-averia-libre', 'font-averia-gruesa-libre', 'font-averia-sans-libre', 'font-averia-serif-libre'
]).

meta_pkg(mac, [
	'reattach-to-user-namespace', karabiner, seil, flux, 'mjolnir-configured', pulse,
	alfred, dropbox, virtualbox, transmission, cleanmymac, tunnelblick,
	vlc, clarify, forklift, gpgtools, 'android-file-transfer', fliqlo,
	evernote, skitch, skype, 'istat-menus', imageoptim,
	qlcolorcode, qlmarkdown, qlprettypatch, qlimagesize, qlstephen,
	'colorpicker-developer', 'colorpicker-hex',
	'iterm2-beta', java, java7,
	'google-chrome', 'google-chrome-canary',
	'firefox', 'firefox-nightly',
	fonts
]).

meta_pkg(desktop, [
	shell, dev, mail, mac, keychain, rkhunter
]).
