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
# NVM_AUTO_USE=true
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000

# where is antibody keeping its stuff?
ANTIBODY_HOME="$(antibody home)"

# tell omz where it lives
export ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh

# quit bugging me!
DISABLE_AUTO_UPDATE="true"

source ~/.zsh_plugins.sh
#

# export NVM_DIR="$HOME/.nvm"
function load_n() {
  [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
}

# Initialize worker
async_start_worker n_worker -n
async_register_callback n_worker load_n
async_job n_worker sleep 0.1

eval $(thefuck --alias f)

bindkey -e

source ~/.bash_aliases
source ~/.bash_functions

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -e ~/.zshrc_extra ]] && source ~/.zshrc_extra

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
