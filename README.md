# myfreeweb/dotfiles 2.0

Modular dotfiles!
Easy installation on virtual machines and servers via SSH.
No symlinks.

A module is a directory with an `apply.sh` file that installs the dotfiles.

## Installation

On the main machine, clone to `~/src/github.com/myfreeweb/dotfiles`.  
And `git submodule update --init --recursive`.  
Get `zsh` if it's not there, `chsh` it.  

On OS X with Homebrew, use `brew bundle` to install all the things listed in the Brewfile.  
Also, [base16](https://github.com/chriskempson/base16)-ocean colorscheme for the terminal.

### Local (example)

    ./install.sh dev-base tmux zsh vim osx python ruby

### Remote (example)

    ./rinstall.sh admin@192.168.1.10 dev-base tmux zsh vim

## Module WTF

### Common

- **dev-base** -- configs for ssh, git, ack, ctags, curl, gpg and other small but essential programs
- **tmux** -- tmux configuration and command helper
- **zsh** -- Z Shell configuration and plugins
- **vim** -- Vim text editor configuration and plugins
- **emacs** -- GNU Emacs text editor configuration and plugins
- **osx** -- Apple OS X defaults, keybindings, KeyRemap4Macbook, Slate

### Language-specific

- **python** -- Python
- **ruby** -- irb, Rails, RubyGems
- **lein** -- Clojure ([Leiningen])
- **ocaml** -- OCaml ([OPAM], [utop])
- **haskell** -- Haskell (cabal, ghci, [hi])

[Leiningen]: http://leiningen.org/
[OPAM]: http://opam.ocaml.org/
[utop]: https://github.com/diml/utop
[hi]: https://github.com/fujimura/hi
