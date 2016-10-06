# OS specific paths
if [[ $OSTYPE == "darwin"* ]]; then
    export PATH=/Library/TeX/texbin:/usr/local/bin:$PATH
elif [[ $OSTYPE == "cygwin" ]]; then
    export PATH=/cygdrive/C/Program\ Files/SumatraPDF:$PATH
    export DISPLAY=:0.0
    if [ -d "/usr/local/share/vim/vim74" ]; then
        export VIMRUNTIME=/usr/local/share/vim/vim74
    elif [ -d "usr/share/vim/vim74" ]; then
        export VIMRUNTIME=/usr/share/vim/vim74
    fi
fi

source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle command-not-found
antigen bundle common-aliases
antigen bundle git
antigen bundle ssh-agent
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

if [[ $OSTYPE == "darwin"* ]]; then
    antigen bundle brew
elif [[ $OSTYPE == "cygwin" ]]; then
    antigen bundle rbenv
    antigen bundle ruby
    antigen bundle gem
fi

# Load the theme
antigen theme mh

# Tell antigen that you're done
antigen apply

zmodload zsh/terminfo
if [[ $OSTYPE == "darwin"* ]]; then
    # Bind keyboard shortcuts for iTerm2 running on Apple MacBook laptops
    bindkey "$terminfo[cuu1]" history-substring-search-up
    bindkey "$terminfo[cud1]" history-substring-search-down
elif [[ $OSTYPE == "cygwin" ]]; then
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
fi

# fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# path to rbenv on Windows
if [[ $OSTYPE == "cygwin" ]]; then
    if command -v rbenv >/dev/null; then
        export RBENV_ROOT=/cygdrive/c/Users/Kegelman/.rbenv
        export PATH="$RBENV_ROOT/bin:$PATH"
        eval "$(rbenv init -)"
    fi
fi
