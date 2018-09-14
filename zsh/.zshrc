autoload -Uz compinit && compinit

cat $HOME/.cache/wal/sequences # run first to prevent flicker
clear

export EDITOR=nvim

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

export PATH=$PATH:/home/piggyslasher/.cargo/bin:$HOME/.local/kitty.app/bin

export PATH=$PATH:/usr/local/go/bin

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
#

export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
}

# Initialize worker
async_start_worker nvm_worker -n
async_register_callback nvm_worker load_nvm
async_job nvm_worker sleep 0.1

eval $(thefuck --alias f)

bindkey -e

source ~/.bash_aliases
source ~/.bash_functions

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# [[ -e ~/.zshrc_extra ]] && source ~/.zshrc_extra
