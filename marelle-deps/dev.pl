% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

% Search
managed_pkg(ack).
managed_pkg(ctags).
command_pkg(pt).
installs_with_go(pt, 'github.com/monochromegane/the_platinum_searcher/cmd/pt').

% Version control
managed_pkg(git).
managed_pkg(mercurial).
command_pkg(bzr).
installs_with_brew(bzr, 'bazaar').
installs_with_pkgng(bzr).

% Deployment
managed_pkg('heroku-toolbelt').

% Editing
command_pkg(vim).
installs_with_brew(vim).
installs_with_pkgng(vim, 'vim-lite').
managed_pkg(emacs).

% Misc
managed_pkg(sloccount).

meta_pkg(dev, [
	ack, ctags, pt, git, mercurial, bzr, vim, sloccount, grunt
]).
