```
                                                                             
                 ▄▀▀                                     █                  ▄
 ▄▄▄▄▄  ▄   ▄  ▄▄█▄▄   ▄ ▄▄   ▄▄▄    ▄▄▄  ▄     ▄  ▄▄▄   █▄▄▄              █ 
 █ █ █  ▀▄ ▄▀    █     █▀  ▀ █▀  █  █▀  █ ▀▄ ▄ ▄▀ █▀  █  █▀ ▀█            █  
 █ █ █   █▄█     █     █     █▀▀▀▀  █▀▀▀▀  █▄█▄█  █▀▀▀▀  █   █           █   
 █ █ █   ▀█      █     █     ▀█▄▄▀  ▀█▄▄▀   █ █   ▀█▄▄▀  ██▄█▀          █    
         ▄▀                                                            ▀     
        ▀▀                                                                   
                                                        
     █           ▄      ▄▀▀    ▀    ▀▀█                 
  ▄▄▄█   ▄▄▄   ▄▄█▄▄  ▄▄█▄▄  ▄▄▄      █     ▄▄▄    ▄▄▄  
 █▀ ▀█  █▀ ▀█    █      █      █      █    █▀  █  █   ▀ 
 █   █  █   █    █      █      █      █    █▀▀▀▀   ▀▀▀▄ 
 ▀█▄██  ▀█▄█▀    ▀▄▄    █    ▄▄█▄▄    ▀▄▄  ▀█▄▄▀  ▀▄▄▄▀ 
                                                        

I definitely spend waaaaaay too much time configuring software I use.

```

# dotfiles

Modular dotfiles!

- A module is a directory with an `apply.sh` file that installs the dotfiles the module contains
- `install.sh` installs multiple modules on the local machine
- `rinstall.sh` installs multiple modules on a remote machine using SSH
- `osx/packages.sh` and `osx/apps.sh` installs OS X Homebrew packages
- `freebsd/desktop.sh` installs FreeBSD packages and system settings for a desktop

- XDG-style `~/.config/application-name/config-file-name` paths are preferred
- Binaries are placed into `~/.local/bin` (and `go`, `pip`, `npm`, `cpan`, `cargo`, etc. are configured to use that directory)
- Repos are placed into `~/src` using Go conventions (e.g. `~/src/github.com/myfreeweb/dotfiles`). `$GOPATH` is `~` and [ghq] is used to clone non-Go repos there
- Keyboard configuration is mostly based on [A Modern Space Cadet]

[ghq]: https://github.com/motemen/ghq
[A Modern Space Cadet]: http://stevelosh.com/blog/2012/10/a-modern-space-cadet/

## Installation

### Common setup (FreeBSD)

```bash
# portsnap fetch extract
# pkg install git sudo
# visudo
$ git clone git@github.com:myfreeweb/dotfiles ~/src/github.com/myfreeweb/dotfiles
$ cd ~/src/github.com/myfreeweb/dotfiles
$ git submodule update --init --recursive
$ (cd freebsd && sudo ./desktop.sh)
$ ./install.sh dev-base bin tmux zsh vim x11 python ruby
$ chsh -s /usr/local/bin/zsh
$ zsh
```

### Common setup (OS X)

```bash
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install git
$ git clone git@github.com:myfreeweb/dotfiles ~/src/github.com/myfreeweb/dotfiles
$ cd ~/src/github.com/myfreeweb/dotfiles
$ git submodule update --init --recursive
$ ./osx/packages.sh
$ ./osx/apps.sh
$ PCKEYBOARD=1 ./install.sh dev-base bin tmux zsh vim osx python ruby
$ sudo sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
$ chsh -s /usr/local/bin/zsh
$ zsh
```

### Remote setup (example)

    ./rinstall.sh dovahkiin@winterhold.local dev-base tmux zsh vim

## Module WTF

### Common

- **dev-base** -- configs for [ssh], [git], [ack], [ctags], [curl], [gpg] and other small but essential programs
- **bin** -- various useful scripts that mostly work
- **tmux** -- [tmux] configuration and command helper
- **zsh** -- [Z Shell] configuration and plugins
- **vim** -- [neovim] text editor configuration and plugins
- **emacs** -- [GNU Emacs] text editor configuration and plugins
- **mail** -- [mutt], [notmuch], [msmtp], [urlview], [hashcash]
- **ranger** -- [ranger] file manager
- **x11** -- [bspwm], [dunst], [st] and other x.org stuff
- **osx** -- Apple OS X `defaults`, [keybindings], [Karabiner], [Seil], [Amethyst]
- **windows** -- PowerShell and other Microsoft Windows stuff

[ssh]: http://www.openssh.com
[git]: http://git-scm.com
[ack]: http://beyondgrep.com
[ctags]: http://ctags.sourceforge.net
[curl]: http://curl.haxx.se
[gpg]: https://www.gnupg.org
[tmux]: http://tmux.sourceforge.net
[Z Shell]: http://zsh.sourceforge.net
[neovim]: https://github.com/neovim/neovim
[GNU Emacs]: https://www.gnu.org/software/emacs/
[keybindings]: https://github.com/ttscoff/KeyBindings
[Karabiner]: https://pqrs.org/osx/karabiner/index.html.en
[Seil]: https://pqrs.org/osx/karabiner/seil.html.en
[Amethyst]: https://github.com/ianyh/Amethyst
[mutt]: http://www.mutt.org
[notmuch]: http://notmuchmail.org
[msmtp]: https://wiki.archlinux.org/index.php/MSMTP
[urlview]: https://github.com/sigpipe/urlview
[hashcash]: http://hashcash.org
[bspwm]: https://github.com/baskerville/bspwm
[dunst]: https://github.com/knopwob/dunst
[st]: http://st.suckless.org/
[ranger]: http://ranger.nongnu.org/

### Language-specific

- **python** -- [Python] REPL configuration
- **ruby** -- [Ruby] irb, Rails, RubyGems configuration
- **node** -- [Node.js] npm configuration
- **lein** -- [Clojure]'s [Leiningen] configuration
- **ocaml** -- [OCaml]'s [OPAM] and [utop] configuration
- **haskell** -- [Haskell]'s [Cabal], ghci, [hi] configuration
- **lua** -- [Lua] [luarocks] configuration

[Python]: https://www.python.org
[Ruby]: https://www.ruby-lang.org/en/
[Node.js]: https://nodejs.org/en/
[Clojure]: http://clojure.org
[Leiningen]: http://leiningen.org
[OCaml]: https://ocaml.org
[OPAM]: https://opam.ocaml.org
[utop]: https://github.com/diml/utop
[Haskell]: https://www.haskell.org
[Cabal]: https://www.haskell.org/cabal/
[hi]: https://github.com/fujimura/hi
[Lua]: http://www.lua.org
[luarocks]: https://rocks.moonscript.org
