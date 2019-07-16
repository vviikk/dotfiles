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
ZSH_THEME_VAGRANT_PROMPT_PREFIX="%{$fg_bold[blue]%}["
ZSH_THEME_VAGRANT_PROMPT_SUFFIX="%{$fg_bold[blue]%}]%{$reset_color%} "
ZSH_THEME_VAGRANT_PROMPT_RUNNING="%{$fg_no_bold[green]%}●"
ZSH_THEME_VAGRANT_PROMPT_POWEROFF="%{$fg_no_bold[red]%}●"
ZSH_THEME_VAGRANT_PROMPT_SUSPENDED="%{$fg_no_bold[yellow]%}●"
ZSH_THEME_VAGRANT_PROMPT_NOT_CREATED="%{$fg_no_bold[white]%}○"

function vagrant_prompt_info() {
test -d .vagrant && test -f Vagrantfile
if [[ "$?" == "0" ]]; then
    statuses=$(vagrant status 2> /dev/null | grep -P "\w+\s+[\w\s]+\s\(\w+\)")
    statuses=("${(f)statuses}")
    printf '%s' $ZSH_THEME_VAGRANT_PROMPT_PREFIX
    for vm_details in $statuses; do
      vm_state=$(echo $vm_details | grep -o -E "saved|poweroff|not created|running")
      if [[ "$vm_state" == "running" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_RUNNING
      elif [[ "$vm_state" == "saved" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_SUSPENDED
      elif [[ "$vm_state" == "not created" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_NOT_CREATED
      elif [[ "$vm_state" == "poweroff" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_POWEROFF
      fi
    done
    printf '%s' $ZSH_THEME_VAGRANT_PROMPT_SUFFIX
  fi
}
PROMPT="$(vagrant_prompt_info)$PROMPT"
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

autoload -Uz compinit && compinit
