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
                                                        

```

# dotfiles

Modular dotfiles!

- A module is a directory with an `apply.sh` file that installs the dotfiles the module contains
- `install.sh` installs multiple modules on the local machine
- `rinstall.sh` installs multiple modules on a remote machine using SSH

## Preferences

- XDG-style `~/.config/application-name/config-file-name` paths are preferred
- Binaries are placed into `~/.local/bin` (and `go`, `pip`, `npm`, `cpan`, `cargo`, etc. are configured to use that directory)
- Repos are placed into `~/src` using Go conventions (e.g. `~/src/github.com/myfreeweb/dotfiles`). `$GOPATH` is `~` and [ghq] is used to clone non-Go repos there
- Keyboard configuration is mostly based on [A Modern Space Cadet]

[ghq]: https://github.com/motemen/ghq
[A Modern Space Cadet]: http://stevelosh.com/blog/2012/10/a-modern-space-cadet/

## Module list

### Common

- **dev-base** -- configs for [ssh], [git], [ack], [ctags], [curl], [gpg] and other small but essential programs
- **bin** -- various useful scripts that mostly work
- **tmux** -- [tmux] configuration and command helper
- **zsh** -- [Z Shell] configuration and plugins
- **vim** -- [neovim] text editor configuration and plugins
- **emacs** -- [GNU Emacs] text editor configuration and plugins
- **mail** -- [mutt], [notmuch], [msmtp], [urlview], [hashcash]
- **ranger** -- [ranger] file manager
- **desktop** -- common freedesktop things: fontconfig, XCompose..
- **x11** -- [dunst], [st], compton, [i3]/[sway] and other X11 stuff (not used currently)
- **osx** -- Apple OS X `defaults`, [keybindings], [Karabiner], [Seil], [Amethyst] (not used in years)
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
[dunst]: https://github.com/knopwob/dunst
[st]: http://st.suckless.org/
[i3]: https://i3wm.org/
[sway]: https://github.com/SirCmpwn/sway
[ranger]: http://ranger.nongnu.org/

### Language-specific

- **python** -- [Python] REPL configuration
- **ruby** -- [Ruby] irb, Rails, RubyGems configuration
- **node** -- [Node.js] npm configuration
- **ocaml** -- [OCaml]'s [OPAM] and [utop] configuration
- **haskell** -- [Haskell]'s [Cabal], [Stack] and ghci configuration
- **lua** -- [Lua] [luarocks] configuration

[Python]: https://www.python.org
[Ruby]: https://www.ruby-lang.org/en/
[Node.js]: https://nodejs.org/en/
[OCaml]: https://ocaml.org
[OPAM]: https://opam.ocaml.org
[utop]: https://github.com/diml/utop
[Haskell]: https://www.haskell.org
[Cabal]: https://www.haskell.org/cabal/
[Stack]: https://docs.haskellstack.org/en/stable/README/
[Lua]: http://www.lua.org
[luarocks]: https://rocks.moonscript.org
