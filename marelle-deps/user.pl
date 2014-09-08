% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

dl(URLDir, Filename) :-
	join(['cd ~/Downloads && rm -f "', Filename, '" && wget "', URLDir, '/', Filename, '"'], Cmd),
	bash(Cmd).

% Nice login welcome message
managed_pkg(archey).
managed_pkg(cowsay).
managed_pkg(fortune).

% Internets
managed_pkg(curl).
managed_pkg(wget).
managed_pkg(libressl).

% Shell
managed_pkg(tmux).
managed_pkg(zsh).
managed_pkg(tree).
command_pkg(ghq).
installs_with_go(ghq, 'github.com/motemen/ghq').
command_pkg(peco).
installs_with_go(peco, 'github.com/peco/peco/cmd/peco').

meta_pkg(shell, [
	archey, cowsay, fortune,
	curl, wget,
	tmux, zsh, tree, ghq, peco
]).

% Security
managed_pkg(keychain).
managed_pkg(rkhunter).

% OS X
managed_pkg('reattach-to-user-namespace') :- platform(osx).

pkg('karabiner') :- platform(osx).
met('karabiner', osx) :- isdir('/Applications/Karabiner.app').
meet('karabiner', osx) :-
	dl('https://pqrs.org/osx/karabiner/files', 'Karabiner-10.2.0.dmg'),
	bash('cd ~/Downloads && hdiutil attach Karabiner-10.2.0.dmg && sudo installer -pkg /Volumes/Karabiner-10.2.0/Karabiner.pkg -target / && hdiutil detach /Volumes/Karabiner-10.2.0').
depends('karabiner', osx, [wget]).

pkg('seil') :- platform(osx).
met('seil', osx) :- isdir('/Applications/Seil.app').
meet('seil', osx) :-
	dl('https://pqrs.org/osx/karabiner/files', 'Seil-10.11.0.dmg'),
	bash('cd ~/Downloads && hdiutil attach Seil-10.11.0.dmg && sudo installer -pkg /Volumes/Seil-10.11.0/Seil.pkg -target / && hdiutil detach /Volumes/Seil-10.11.0').
depends('seil', osx, [wget]).

pkg('mjolnir-app') :- platform(osx).
met('mjolnir-app', osx) :- isdir('/Applications/Mjolnir.app').
meet('mjolnir-app', osx) :-
	dl('https://github.com/mjolnir-io/mjolnir/releases/download/0.4.2', 'Mjolnir-0.4.2.tgz'),
	bash('cd ~/Downloads && tar xvf Mjolnir-0.4.2.tgz -C/Applications').
depends('mjolnir-app', osx, [wget]).

luarocks_pkg('mjolnir.hotkey').
luarocks_pkg('mjolnir.application').
luarocks_pkg('mjolnir.cmsj.appfinder').
luarocks_pkg('mjolnir.sd.grid').
meta_pkg(mjolnir, [
	'mjolnir-app', 'mjolnir.hotkey', 'mjolnir.application',
	'mjolnir.cmsj.appfinder', 'mjolnir.sd.grid'
]).

pkg(fira).
depends(fira, _, [ghq]).
met(fira, osx) :- isfile('~/Library/Fonts/FiraMono-Regular.otf').
meet(fira, osx) :- bash('ghq get -p mozilla/Fira && cp $GOPATH/src/github.com/mozilla/Fira/otf/*.otf ~/Library/Fonts').
pkg('source-sans-pro').
depends('source-sans-pro', osx, [wget]).
met('source-sans-pro', osx) :- isfile('~/Library/Fonts/SourceSansPro-Regular.otf').
meet('source-sans-pro', osx) :-
	dl('https://github.com/adobe-fonts/source-sans-pro/archive/2.010R-ro', '1.065R-it.tar.gz'),
	bash('cd ~/Downloads && tar xf 1.065R-it.tar.gz && cp source-sans-pro-2.010R-ro-1.065R-it/OTF/*.otf ~/Library/Fonts').
pkg('source-code-pro').
depends('source-code-pro', osx, [wget]).
met('source-code-pro', osx) :- isfile('~/Library/Fonts/SourceCodePro-Regular.otf').
meet('source-code-pro', osx) :-
	dl('https://github.com/adobe-fonts/source-code-pro/archive/1.017R', '1.017R.tar.gz'),
	bash('cd ~/Downloads && tar xf 1.017R.tar.gz && cp source-code-pro-1.017R/OTF/*.otf ~/Library/Fonts').
pkg('source-serif-pro').
depends('source-serif-pro', osx, [wget]).
met('source-serif-pro', osx) :- isfile('~/Library/Fonts/SourceSerifPro-Regular.otf').
meet('source-serif-pro', osx) :-
	dl('https://github.com/adobe-fonts/source-serif-pro/archive/1.014R', '1.014R.tar.gz'),
	bash('cd ~/Downloads && tar xf 1.014R.tar.gz && cp source-serif-pro-1.014R/OTF/*.otf ~/Library/Fonts').
meta_pkg(fonts, [
	fira, 'source-sans-pro', 'source-code-pro', 'source-serif-pro'
]).

meta_pkg(mac, [
	'reattach-to-user-namespace', karabiner, seil, mjolnir, fonts
]).

meta_pkg(desktop, [
	shell, dev, mac, keychain, rkhunter
]).
