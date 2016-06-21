# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify
unsetopt beep nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/marissaferrante/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
. `brew --prefix`/etc/profile.d/z.sh
export PATH="/Library/TeX/texbin:/usr/local/bin:$PATH"
