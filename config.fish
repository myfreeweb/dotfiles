# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://bitbucket.org/sjl/dotfiles/src/cbbbc897e9b3/fish/config.fish
# http://selena.deckelmann.usesthis.com/

# Setting env {{{
set CODEDIR $HOME/Code
if test -s $HOME/.dotfiles_location
  set DOTFILES (cat $HOME/.dotfiles_location)
else
  set DOTFILES $CODEDIR/dotfiles
  echo "~/.dotfiles_location not found, reinstall dotfiles"
end

set PATH "/usr/local/bin" $PATH
set PATH "/usr/local/sbin" $PATH
for dir in $DOTFILES/bin/*
  if test -d $dir
    set PATH $dir $PATH
  end
end
set PATH "$DOTFILES/bin" $PATH

# JS
set PATH "/usr/local/share/npm/bin" $PATH

# Java
set -gx JAVA_HOME (/usr/libexec/java_home)
set PATH "$JAVA_HOME/bin" $PATH
set -gx JRUBY_OPTS "-J-XX:+TieredCompilation -J-XX:TieredStopAtLevel=1 -J-noverify"

# TeX
set PATH "/usr/texbin" $PATH

# Fish
set -gx fish_greeting ''
set -gx COMMAND_MODE unix2003

# Less
set -gx LESS "-R"

# Generic settings
set -gx CLICOLOR "yes"
set -gx EDITOR "vim"
set -gx PAGER "less"
set -gx LANG "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"
set -gx LEDGER_FILE "$HOME/Documents/my.ledger"
# }}}

# Functions {{{
. $DOTFILES/rc
alias z 'pushd (fasd -d $argv)'

function mcd
  mkdir -p "$argv"
  cd "$argv"
end

function pd
  cd (pro search $argv)
end

function emacs
  set OLDTERM $TERM
  set -gx TERM 'xterm-256color'
  command emacs $argv
  set -gx TERM $OLDTERM
end
# }}}

# Prompt {{{
function fish_prompt
  set last_status $status
  echo

  set_color black --background=green
  printf '%s ' (prompt_pwd)
  set -g lastc green

  if git rev-parse --show-toplevel >/dev/null 2>&1
    set_color white --background=blue
    printf ' ⭠ '
    printf '%s ' (git branch --contains HEAD ^/dev/null | grep '*' | tr -s ' ' | cut -d ' ' -f2)
  end

  if [ -n "$VIRTUAL_ENV" ]
    set_color black --background=yellow
    printf ' %s ' (basename "$VIRTUAL_ENV")
  end

#  if test -s $HOME/.rbenv/version
#    set_color black --background=purple
#    printf ' %s ' (cat $HOME/.rbenv/version)
#  end

  if test $last_status -ne 0
    set_color black --background=red
    printf ' %d ' $last_status
  end

  set_color normal
  printf '$ '
end
# }}}

bind \e\[O true
bind \e\[I true
