% This came from Greg V's dotfiles:
%      https://github.com/myfreeweb/dotfiles
% Feel free to steal it, but attribution is nice

% JavaScript / node.js
managed_pkg(node).
:- multifile npm_pkg/1.
:- multifile npm_pkg/2.
:- multifile installs_with_npm/1.
:- multifile installs_with_npm/2.
pkg(N) :- npm_pkg(N, _).
depends(N, _, [node]) :- installs_with_npm(N, _).
npm_pkg(N, N) :- npm_pkg(N).
installs_with_npm(N, NpmPkgUrl) :- npm_pkg(N, NpmPkgUrl).
installs_with_npm(N, N) :- installs_with_npm(N).
met(N, _) :-
	npm_pkg(N, _),
	bash(['node -e "require(\'', N, '\')" >/dev/null 2>/dev/null']). % error returns a non-zero exit code
meet(N, _) :-
	installs_with_npm(N, NpmPkgUrl),
	npm_install(NpmPkgUrl).
npm_install(NpmPkgUrl) :-
	join(['Installing ', NpmPkgUrl, ' with npm'], Msg),
	writeln(Msg),
	bash(['npm install -g ', NpmPkgUrl]).
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
	go_pkg(G, GoPkgUrl),
	getenv('GOPATH', GoPath),
	join([GoPath, '/src/', GoPkgUrl], GoPkgPath),
	isdir(GoPkgPath).
meet(G, _) :-
	installs_with_go(G, GoPkgUrl),
	go_install(GoPkgUrl).
go_install(GoPkgUrl) :-
	join(['Installing ', GoPkgUrl, ' with go'], Msg),
	writeln(Msg),
	bash(['go get ', GoPkgUrl]).

% Lua
command_pkg(lua).
installs_with_brew(lua, 'homebrew/versions/lua52').
command_pkg(luarocks).
installs_with_brew(luarocks, 'luarocks --with-lua52').
depends(luarocks, _, [lua]).
:- multifile luarocks_pkg/1.
:- multifile luarocks_pkg/2.
:- multifile installs_with_luarocks/1.
:- multifile installs_with_luarocks/2.
pkg(N) :- luarocks_pkg(N, _).
depends(N, _, [luarocks]) :- installs_with_luarocks(N, _).
luarocks_pkg(N, N) :- luarocks_pkg(N).
installs_with_luarocks(N, LuarocksPkgUrl) :- luarocks_pkg(N, LuarocksPkgUrl).
installs_with_luarocks(N, N) :- installs_with_luarocks(N).
met(N, _) :-
	luarocks_pkg(N, _),
	bash(['! (lua -e "require \'', N, '\'" 2>&1 | grep "module .* not found")']). % only error when module not found, because mjolnir modules fail from lua cli
meet(N, _) :-
	installs_with_luarocks(N, LuarocksPkgUrl),
	luarocks_install(LuarocksPkgUrl).
luarocks_install(LuarocksPkgUrl) :-
	join(['Installing ', LuarocksPkgUrl, ' with luarocks'], Msg),
	writeln(Msg),
	bash(['luarocks install ', LuarocksPkgUrl]).
