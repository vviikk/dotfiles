cat $HOME/.cache/wal/sequences # run first to prevent flicker
clear

export EDITOR=nvim

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

export PATH=$PATH:/home/piggyslasher/.cargo/bin

# antigen
# source $HOME/.antigenrc


# wal -fq ~/dotfiles/brogrammer.json
neofetch

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /Users/vramanujam/.travis/travis.sh ] && source /Users/vramanujam/.travis/travis.sh

autoload -Uz compinit && compinit

# source <(antibody init)
# antibody bundle < ~/.zsh_plugins.txt

source ~/.zsh_plugins.sh

# source $HOME/test.sh
source .bash_aliases

