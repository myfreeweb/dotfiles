% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice


% JavaScript / node.js
managed_pkg(node).
managed_pkg(npm).
:- multifile npm_pkg/1.
:- multifile npm_pkg/2.
:- multifile installs_with_npm/1.
:- multifile installs_with_npm/2.
pkg(N) :- npm_pkg(N, _).
depends(N, _, [node]) :- installs_with_npm(N, _).
depends(N, freebsd, [npm]) :- installs_with_npm(N, _).
npm_pkg(N, N) :- npm_pkg(N).
installs_with_npm(N, NpmPkgUrl) :- npm_pkg(N, NpmPkgUrl).
installs_with_npm(N, N) :- installs_with_npm(N).
met(N, _) :-
	installs_with_npm(N, _),
	getenv('HOME', Home),
	join([Home, '/.local/lib/node_modules/', N], NpmPkgPath),
	isdir(NpmPkgPath).
meet(N, _) :-
	installs_with_npm(N, NpmPkgUrl),
	npm_install(NpmPkgUrl).
npm_install(NpmPkgUrl) :-
	join(['Installing ', NpmPkgUrl, ' with npm'], Msg),
	writeln(Msg),
	sh(['npm config set prefix ~/.local && npm install -g ', NpmPkgUrl]).
command_pkg(grunt).
installs_with_npm(grunt, 'grunt-cli').

% Go
managed_pkg(go).
depends(go, _, [git, mercurial, bzr]).
:- multifile go_pkg/2.
:- multifile installs_with_go/2.
pkg(G) :- go_pkg(G, _).
depends(G, _, [go]) :- installs_with_go(G, _).
installs_with_go(G, GoPkgUrl) :- go_pkg(G, GoPkgUrl).
met(G, _) :-
	installs_with_go(G, GoPkgUrl),
	getenv('GOPATH', GoPath),
	join([GoPath, '/src/', GoPkgUrl], GoPkgPath),
	isdir(GoPkgPath).
meet(G, _) :-
	installs_with_go(G, GoPkgUrl),
	go_install(GoPkgUrl).
go_install(GoPkgUrl) :-
	join(['Installing ', GoPkgUrl, ' with go'], Msg),
	writeln(Msg),
	sh(['go get ', GoPkgUrl]).
