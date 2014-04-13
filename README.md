# myfreeweb/dotfiles 2.0

Modular dotfiles!
Easy installation on virtual machines and servers via SSH.
No symlinks.

A module is a directory with an `apply.sh` file that installs the dotfiles.

## Installation

On the main machine, clone to `~/Code/dotfiles`.  
Get `zsh`.  
Don't forget to do on OS X: `brew install reattach-to-user-namespace`.

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
- **lein** -- Leiningen (Clojure)
