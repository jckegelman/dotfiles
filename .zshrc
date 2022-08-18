alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ll='ls -alF'

PATH=$(pyenv root)/shims:$PATH

if command -v pyenv &>/dev/null; then
  eval "$(pyenv init -)"
fi
if command -v pyenv-virtualenv &>/dev/null; then
  eval "$(pyenv virtualenv-init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

export PATH="$HOME/.poetry/bin:$PATH"

if command -v jenv &>/dev/null; then
  eval "$(jenv init -)"
fi

bindkey "[D" backward-word
bindkey "[C" forward-word

export PATH="/usr/local/opt/scala@2.12/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
