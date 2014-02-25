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
link vim
link emacs.d
link inputrc
link lesskey
link curlrc
link psqlrc
link_custom gpg.conf $HOME/.gnupg/gpg.conf
link_custom vim/vimrc $HOME/.vimrc
link_custom vim/gvimrc $HOME/.gvimrc
mkdir -p $HOME/.ssh
link_custom ssh_config $HOME/.ssh/config
mkdir -p $HOME/.lein
link_custom lein/init.clj $HOME/.lein/init.clj
link_custom lein/profiles.clj $HOME/.lein/profiles.clj

echo "vim/tmp vim/tmp/undo vim/tmp/backups" | xargs mkdir -p

echo "Installed dotfiles!"
