alias v=nvim
alias vim=nvim
echo 'bashrc sourced'
# [ -n "$PS1" ] && source ~/.bash_profile;
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# added by travis gem
[ -f /Users/vramanujam/.travis/travis.sh ] && source /Users/vramanujam/.travis/travis.sh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
