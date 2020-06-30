[ -f $HOME/.cache/wal/sequences ] && cat $HOME/.cache/wal/sequences

bindkey "^?" backward-delete-char
bindkey -v

export EDITOR=nvim

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

PYTHONBIN=$(python3 -m site --user-base)/bin
export PATH=$PATH:$PYTHONBIN
export PATH=$PATH:$HOME/.cargo/bin:$HOME/.local/kitty.app/bin

export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:$HOME/Android/Sdk

export BAT_THEME="Default"

[ -f /Users/vramanujam/.travis/travis.sh ] && source /Users/vramanujam/.travis/travis.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=13"
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

# where is antibody keeping its stuff?
ANTIBODY_HOME="$(antibody home)"

# quit bugging me!
DISABLE_AUTO_UPDATE="true"

autoload -Uz compinit && compinit

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -e ~/.zshrc_extra ]] && source ~/.zshrc_extra
export PATH="/usr/local/sbin:$PATH"

source ~/.zsh_plugins.sh
source ~/.bash_aliases
source ~/.bash_functions
