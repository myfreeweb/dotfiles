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

[![Screenshot](https://imgur.com/mIkLDkN.png)](https://imgur.com/mIkLDkN)

# dotfiles 2.0

Modular dotfiles!
Easy installation on virtual machines and servers via SSH.
No symlinks.

A module is a directory with an `apply.sh` file that installs the dotfiles.

Also: [Marelle] deps.

[Marelle]: https://github.com/larsyencken/marelle

## Installation

Required: [git], [SWI-Prolog], [Z Shell].

Common setup:

```bash
$ git clone git@github.com:larsyencken/marelle ~/src/github.com/larsyencken/marelle
$ git clone git@github.com:myfreeweb/dotfiles  ~/src/github.com/myfreeweb/dotfiles
$ cd ~/src/github.com/myfreeweb/dotfiles
$ git submodule update --init --recursive
$ ./install.sh dev-base bin zsh tmux
$ sudo sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
$ chsh -s /usr/local/bin/zsh
$ zsh
$ marelle meet desktop
```

### Local (example)

    ./install.sh dev-base bin tmux zsh vim osx python ruby
    
    # If using a PC keyboard on a Mac
    PCKEYBOARD=1 ./install.sh osx

### Remote (example)

    ./rinstall.sh dovahkiin@winterhold.local dev-base tmux zsh vim

## Module WTF

### Common

- **dev-base** -- configs for [ssh], [git], [ack], [ctags], [curl], [gpg] and other small but essential programs
- **bin** -- various useful scripts that mostly work
- **tmux** -- [tmux] configuration and command helper
- **zsh** -- [Z Shell] configuration and plugins
- **vim** -- [Vim] *or [neovim]* text editor configuration and plugins
- **emacs** -- [GNU Emacs] text editor configuration and plugins
- **mail** -- [mutt], [notmuch], [msmtp], [urlview], [hashcash]
- **ranger** -- [ranger] file manager
- **x11** -- [xmonad], [xmobar], [dunst], [st] and other x.org stuff
- **osx** -- Apple OS X `defaults`, [keybindings], [Karabiner], [Seil], [Amethyst] -- a lot of the keyboard stuff is based on [A Modern Space Cadet]
- **windows** -- PowerShell and other Microsoft Windows stuff

[ssh]: http://www.openssh.com
[git]: http://git-scm.com
[ack]: http://beyondgrep.com
[ctags]: http://ctags.sourceforge.net
[curl]: http://curl.haxx.se
[gpg]: https://www.gnupg.org
[tmux]: http://tmux.sourceforge.net
[Z Shell]: http://zsh.sourceforge.net
[Vim]: http://www.vim.org
[neovim]: https://github.com/neovim/neovim
[GNU Emacs]: https://www.gnu.org/software/emacs/
[keybindings]: https://github.com/ttscoff/KeyBindings
[Karabiner]: https://pqrs.org/osx/karabiner/index.html.en
[Seil]: https://pqrs.org/osx/karabiner/seil.html.en
[Amethyst]: https://github.com/ianyh/Amethyst
[A Modern Space Cadet]: http://stevelosh.com/blog/2012/10/a-modern-space-cadet/
[mutt]: http://www.mutt.org
[notmuch]: http://notmuchmail.org
[msmtp]: https://wiki.archlinux.org/index.php/MSMTP
[urlview]: https://github.com/sigpipe/urlview
[hashcash]: http://hashcash.org
[xmonad]: http://xmonad.org
[xmobar]: http://projects.haskell.org/xmobar/
[dunst]: https://github.com/knopwob/dunst
[st]: http://st.suckless.org/
[ranger]: http://ranger.nongnu.org/

### Language-specific

- **python** -- [Python] REPL configuration
- **ruby** -- [Ruby] irb, Rails, RubyGems configuration
- **lein** -- [Clojure]'s [Leiningen] configuration
- **ocaml** -- [OCaml]'s [OPAM] and [utop] configuration
- **haskell** -- [Haskell]'s [Cabal], ghci, [hi] configuration
- **lua** -- [Lua] [luarocks] configuration

[SWI-Prolog]: http://www.swi-prolog.org/
[Python]: https://www.python.org
[Ruby]: https://www.ruby-lang.org/en/
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
