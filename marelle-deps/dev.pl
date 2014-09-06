% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

% Search
managed_pkg(ack).
managed_pkg(ctags).
command_pkg(pt).
installs_with_go(pt, 'github.com/monochromegane/the_platinum_searcher').

% Version control
managed_pkg(git).

% Deployment
managed_pkg('heroku-toolbelt').

% Editing
managed_pkg(vim).
managed_pkg(neovim).
managed_pkg(emacs).

% Misc
managed_pkg(sloccount).

meta_pkg(dev, [
	ack, ctags, pt, git, 'heroku-toolbelt', vim, neovim, sloccount, grunt
]).
