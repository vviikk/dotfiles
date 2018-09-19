autoload -Uz compinit && compinit

cat $HOME/.cache/wal/sequences # run first to prevent flicker
clear

export EDITOR=nvim

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

export PATH=$PATH:/home/piggyslasher/.cargo/bin:$HOME/.local/kitty.app/bin

export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:$HOME/Android/Sdk

export BAT_THEME="Default"

# wal -fq ~/dotfiles/brogrammer.json
neofetch

[ -f /Users/vramanujam/.travis/travis.sh ] && source /Users/vramanujam/.travis/travis.sh


# source <(antibody init)
# antibody bundle < ~/.zsh_plugins.txt

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=13"
NVM_AUTO_USE=true
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000


source ~/.zsh_plugins.sh

eval $(thefuck --alias f)

bindkey -e

source ~/.bash_aliases
source ~/.bash_functions

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
