% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

% Nice login welcome message
managed_pkg(archey).
managed_pkg(cowsay).

% Internets
managed_pkg(curl).
managed_pkg(wget).
managed_pkg(libressl).
managed_pkg(openssh).

% Shell
managed_pkg(tmux).
managed_pkg(zsh).
managed_pkg(tree).
command_pkg(ghq).
installs_with_go(ghq, 'github.com/motemen/ghq').
command_pkg(peco).
installs_with_go(peco, 'github.com/peco/peco/cmd/peco').

meta_pkg(shell, [
	archey, cowsay,
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
	bash('cd ~/Downloads && wget https://pqrs.org/osx/karabiner/files/Karabiner-10.2.0.dmg && hdiutil attach Karabiner-10.2.0.dmg && sudo installer -pkg /Volumes/Karabiner-10.2.0/Karabiner.pkg -target / && hdiutil detach /Volumes/Karabiner-10.2.0').
depends('karabiner', osx, [wget]).

pkg('seil') :- platform(osx).
met('seil', osx) :- isdir('/Applications/Seil.app').
meet('seil', osx) :-
	bash('cd ~/Downloads && wget https://pqrs.org/osx/karabiner/files/Seil-10.11.0.dmg && hdiutil attach Seil-10.11.0.dmg && sudo installer -pkg /Volumes/Seil-10.11.0/Seil.pkg -target / && hdiutil detach /Volumes/Seil-10.10.0').
depends('seil', osx, [wget]).

pkg('mjolnir-app') :- platform(osx).
met('mjolnir-app', osx) :- isdir('/Applications/Mjolnir.app').
meet('mjolnir-app', osx) :-
	bash('cd ~/Downloads && wget https://github.com/mjolnir-io/mjolnir/releases/download/0.4.2/Mjolnir-0.4.2.tgz && tar xvf Mjolnir-0.4.2.tgz -C/Applications').
depends('mjolnir-app', osx, [wget]).

luarocks_pkg('mjolnir.hotkey').
luarocks_pkg('mjolnir.application').
luarocks_pkg('mjolnir.cmsj.appfinder').
luarocks_pkg('mjolnir.sd.grid').
meta_pkg(mjolnir, [
	'mjolnir-app', 'mjolnir.hotkey', 'mjolnir.application',
	'mjolnir.cmsj.appfinder', 'mjolnir.sd.grid'
]).

meta_pkg(mac, [
	'reattach-to-user-namespace', mjolnir, karabiner, seil
]).

meta_pkg(desktop, [
	shell, dev, mac, keychain, rkhunter, openssh
]).
