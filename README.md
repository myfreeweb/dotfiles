# myfreeweb/dotfiles 2.0

Modular dotfiles!
Easy installation on virtual machines and servers via SSH.
No symlinks.
[Marelle] for optional automated installation.

A module is a directory with an `apply.sh` file that installs the dotfiles.

![Screenshot](https://files.app.net/2nnl9Hsmq.png)

## Installation

Prepare OS X:

```bash
$ ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" 
$ brew install zsh swi-prolog
```

Common setup:

```bash
$ mkdir -p ~/.local
$ git clone git@github.com:larsyencken/marelle ~/.local/marelle
$ mkdir -p ~/src/github.com/myfreeweb
$ git clone git@github.com:myfreeweb/dotfiles ~/src/github.com/myfreeweb/dotfiles
$ cd ~/src/github.com/myfreeweb/dotfiles
$ git submodule update --init --recursive
$ ./install.sh dev-base bin zsh
$ sudo sh -c 'echo "/usr/local/bin/zsh" >> /etc/shells'
$ chsh -s /usr/local/bin/zsh
$ zsh
$ marelle meet desktop
```

Also, get [base16] colorschemes for the terminal.

### Local (example)

    ./install.sh dev-base bin tmux zsh vim osx python ruby
    
    # If using a PC keyboard on a Mac
    PCKEYBOARD=1 ./install.sh osx

### Remote (example)

    ./rinstall.sh dovahkiin@winterhold.local dev-base tmux zsh vim

## Module WTF

### Common

- **dev-base** -- configs for ssh, git, ack, ctags, curl, gpg and other small but essential programs
- **bin** -- various useful scripts that mostly work
- **tmux** -- tmux configuration and command helper
- **zsh** -- Z Shell configuration and plugins
- **vim** -- Vim (or [neovim]) text editor configuration and plugins
- **emacs** -- GNU Emacs text editor configuration and plugins
- **osx** -- Apple OS X `defaults`, [keybindings], [Karabiner], [Seil], [Mjolnir] -- a lot of the keyboard stuff is based on [A Modern Space Cadet]
- **firefox** -- userChrome.css for Mozilla Firefox

### Language-specific

- **python** -- Python
- **ruby** -- irb, Rails, RubyGems
- **lein** -- [Leiningen]
- **ocaml** -- [OPAM], [utop]
- **haskell** -- [Cabal], ghci, [hi]
- **lua** -- [luarocks]

[Marelle]: https://github.com/larsyencken/marelle
[Homebrew]: http://brew.sh
[base16]: https://github.com/chriskempson/base16
[neovim]: https://github.com/neovim/neovim
[keybindings]: https://github.com/ttscoff/KeyBindings
[Karabiner]: https://pqrs.org/osx/karabiner/index.html.en
[Seil]: https://pqrs.org/osx/karabiner/seil.html.en
[Mjolnir]: http://mjolnir.io/ 
[A Modern Space Cadet]: http://stevelosh.com/blog/2012/10/a-modern-space-cadet/
[Leiningen]: http://leiningen.org/
[OPAM]: http://opam.ocaml.org/
[utop]: https://github.com/diml/utop
[Cabal]: http://www.haskell.org/cabal/
[hi]: https://github.com/fujimura/hi
[luarocks]: https://rocks.moonscript.org/
