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

% Mail
pkg(mutt).
depends(mutt, freebsd, [libressl]).
installs_with_brew(mutt, mutt, '--with-trash-patch --with-gpgme').
installs_with_ports(mutt, 'mail/mutt', 'WITH="FLOCK GPGME IDN SIDEBAR_PATCH TRASH_PATCH" WITHOUT="XML DOCS EXAMPLES"').
managed_pkg(msmtp).
managed_pkg(contacts).
managed_pkg(antiword).
managed_pkg(urlview).
managed_pkg(hashcash).
managed_pkg(notmuch).
meta_pkg('mail-base', [
	mutt, urlview, hashcash, notmuch
]).
meta_pkg(mail, osx,     ['mail-base', msmtp, contacts]).
meta_pkg(mail, freebsd, ['mail-base', w3m, antiword]).

% Security
managed_pkg(rkhunter).
command_pkg(signify).
installs_with_ports(signify, 'security/signify').
installs_with_brew(signify, 'signify-osx').

% Shell
managed_pkg(tmux).
managed_pkg(zsh).
managed_pkg(tree).
managed_pkg(ncdu).
managed_pkg(toilet).
managed_pkg(jq).
command_pkg(ranger).
installs_with_pkgng(ranger, 'sysutils/py-ranger').
installs_with_brew(ranger).
command_pkg(ghq).
installs_with_go(ghq, 'github.com/motemen/ghq').
command_pkg(peco).
installs_with_go(peco, 'github.com/peco/peco/cmd/peco').
command_pkg('syncthing-cli').
installs_with_go('syncthing-cli', 'github.com/syncthing/syncthing-cli').
pip_pkg(httpie).
pip_pkg(requests). % used by pinboard_xml

meta_pkg(shell, [
	welcome, cowsay, fortune,
	curl, wget, signify,
	tmux, zsh, tree, ncdu, toilet, jq,
	ghq, peco, httpie, requests
]).
