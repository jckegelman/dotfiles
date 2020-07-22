alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ll='ls -alF'

PATH=$(pyenv root)/shims:$PATH

if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
fi
if command -v pyenv-virtualenv &>/dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi
