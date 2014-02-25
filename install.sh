#!/bin/zsh

pwd > ~/.dotfiles_location

link() {
  rm $HOME/.$1
  ln -s $(pwd)/$1 $HOME/.$1
}
link_custom() {
  rm $2
  ln -s $(pwd)/$1 $2
}

# don't even think about "link *rc", will remove all the rcs
link emacs.d
link inputrc
link lesskey
link curlrc
link psqlrc
link_custom gpg.conf $HOME/.gnupg/gpg.conf
mkdir -p $HOME/.ssh
link_custom ssh_config $HOME/.ssh/config

echo "Installed dotfiles!"
