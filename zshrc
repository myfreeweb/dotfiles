# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# http://selena.deckelmann.usesthis.com/
# https://github.com/mathiasbynens/dotfiles/blob/master/.functions

# Loading plugins, setting variables {{{
export CODEDIR=$HOME/Code
if [[ -e $HOME/.dotfiles_location ]]; then
  export DOTFILES=$(cat $HOME/.dotfiles_location)
else
  export DOTFILES=$HOME/Code/dotfiles
  echo "~/.dotfiles_location not found, reinstall dotfiles"
fi

# brew must be in path before zshuery
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

source $DOTFILES/vendor/zsh-hl/zsh-syntax-highlighting.zsh
source $DOTFILES/zshuery/zshuery.sh
load_defaults
load_aliases
load_completion $DOTFILES/zshuery/completion
load_correction

for dir in $DOTFILES/bin/*(/); do
  export PATH=$dir:$PATH
done
export PATH=$DOTFILES/bin:$HOME/.cabal/bin:$PATH
if [[ $HAS_BREW == 1 ]]; then
  BREWGO=$(brew --prefix go)
  [[ -d $BREWGO ]] && export GOROOT=$BREWGO && export GOBIN=$BREWGO/bin \
    && export GOPATH=$HOME/Code/go && export PATH=$GOPATH/bin:$GOBIN:$PATH
fi

# JS
export NODE_PATH=/usr/local/lib/node_modules
export PATH=/usr/local/share/npm/bin:$PATH

# Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH
export JRUBY_OPTS="-J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -J-noverify"
runjava() {
  cp $1 /tmp/Main.java
  (cd /tmp && javac Main.java && echo "--- compiled, running" && java Main)
}

# Ruby
export RBXOPT=-X19
export RBENV_ROOT=/usr/local/var/rbenv
[[ -e $RBENV_ROOT ]] && eval "$(rbenv init -)"

# Python
export PYTHONDONTWRITEBYTECODE=true
export VIRTUALENV_DISTRIBUTE=true
export PIP_USE_MIRRORS=true
export PYTHONSTARTUP=$DOTFILES/pythonrc.py

# Postgres
export PATH=/Applications/Postgres.app/Contents/MacOS/bin:$PATH
#export DYLD_FALLBACK_LIBRARY_PATH=/Applications/Postgres.app/Contents/MacOS/lib:/usr/lib:$DYLD_LIBRARY_PATH

# Emacs
export PATH=$HOME/.cask/bin:$PATH

# TeX
export PATH=/usr/texbin:$PATH

# iOSOpenDev
export iOSOpenDevPath=/opt/iOSOpenDev
export iOSOpenDevDevice="192.168.1.148"
export PATH=$iOSOpenDevPath/bin:$PATH

# Less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;33;146m'
export LESS="-R"

# Generic settings
export CLICOLOR="yes"
export EDITOR="vim"
export PAGER="less"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
# }}}

# Custom settings, aliases and functions {{{
source $DOTFILES/rc
alias "ps?"=psack
dighost() { host $(dig $1 | grep ANSWER -C 1 | tail -n 1 | awk '{ print $5 }') }
echoarrow() { echo "$fg_bold[black]====> $fg_no_bold[yellow]$*$reset_color" }
updatestuff() {
  echoarrow "Updating dotfiles w/ submodules" && (cd $DOTFILES && git pull && git su)
  [[ $HAS_BREW == 1 ]] && echoarrow "Updating Homebrew" && brew update
}
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

chpwd() { update_terminal_cwd; }
precmd() {
  # $? in prompt is wrong, can't pass %? to conditionals
  if [[ $? == 0 ]]; then SMILEY=')'; else SMILEY='('; fi
}

prompts '%{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%} %{$fg_no_bold[yellow]%}:$SMILEY%{$reset_color%} ' '%{$fg[red]%}$(ruby_version)%{$reset_color%}'
setopt auto_pushd
bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey "\e[3~" delete-char # Del
# }}}

# Have to load these plugins after... something
source $DOTFILES/vendor/zsh-hss/zsh-history-substring-search.zsh
eval "$($DOTFILES/bin/fasd/fasd --init auto)"
[[ -e $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

[[ -e $(which fortune) ]] && fortune | (cowsay -f tux || cat) 2&> /dev/null | (lolcat || cat) 2&>/dev/null
