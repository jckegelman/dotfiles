source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle git
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search 
antigen bundle ssh-agent

if [[ $CURRENT_OS == 'OS X' ]]; then
	antigen bundle brew
elif [[ $CURRENT_OS == 'Cygwin' ]]; then
	antigen bundle cygwin
fi

# Load the theme
antigen theme mh

# Tell antigen that you're done
antigen apply

# Bind keyboard shortcuts for iTerm2 running on Apple MacBook laptops
zmodload zsh/terminfo
bindkey "$terminfo[cuu1]" history-substring-search-up
bindkey "$terminfo[cud1]" history-substring-search-down
