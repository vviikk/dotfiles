#!/usr/bin/env bash
autoload bashcompinit
bashcompinit

alias rr="clear && exec $SHELL -l"
alias gg=googler
alias ZZ=exit
alias ls-scripts='echo $(node -p -e "JSON.stringify(require(process.cwd()+\"/package.json\").scripts)") | jq '.' || python -m json.tool || cat'

alias v=lvim
alias vim=lvim
alias nvim=lvim
alias abl='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'
alias ssh="TERM=xterm ssh"
alias code='$(which code-insiders)'

# alias for copy move and remove
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

which devcontainer-insiders &> /dev/null && alias devcontainer=devcontainer-insiders || true

if command -v exa &> /dev/null
then
  alias exa='exa --icons'
else
  unalias ls
fi

# copy the public key
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

[ -e  thefuck ] && eval '$(thefuck --alias f)'

clone() {
  git clone "https://github.com/$1.git"
}

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

alias copyLast='echo !! | pbcopy'

# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
# alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

if command -v bat &> /dev/null
then
  alias cat=bat
fi

alias r='ranger'
alias emulator='~/Library/Android/sdk/emulator/emulator' 

[[ -f .bash_secrets ]] && source .bash_secrets

export AWS_SDK_LOAD_CONFIG=1  # Load the AWS_PROFILE in terraform calls

# alias git=hub
[ -e hub ] && eval "$(hub alias -s)"

function sshake() {
  ssh-copy-id -i ~/.ssh/id_rsa.pub "$1"
}

function pi() {
  ssh root@pi
}

function pidc() {
  ssh root@pi "docker-compose $@"
}

function pil() {
  ssh root@pi "docker-compose logs -f $@"
}


function gitsearch()
{
   searchCrit='stash\|'$1
   git stash list | while IFS=: read STASH ETC; do echo "$STASH: $ETC"; git diff --stat $STASH~..$STASH --; done | grep -e $searchCrit
}

alias githunt=gitsearch

gch() {
 git checkout “$(git branch — all | fzf| tr -d ‘[:space:]’)”
}

#### WORK STUFF ####
WORK_SRC="$HOME/work/tk-meta"

gt() {
    if [[ -e $WORK_SRC/$1 ]]; then
        cd $WORK_SRC/$1
    else
        cd "$1"
        return 1
    fi
}

gdc() {
    if [[ -e $WORK_SRC/$1 ]]; then
        cd $WORK_SRC/$1 && dc
    else
        print "There is no such project: $1"
        return 1
    fi
}

_repo_complete() {
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD - 1]}"
    opts=$(for x in $(ls -d ${WORK_SRC}/*/ | xargs -n1 basename); do echo ${x}; done)
    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
}

complete -F _repo_complete gt
complete -F _repo_complete gdc

antibodyinit() {
  antibody bundle < "$HOME/dotfiles/antibody/.zsh_plugins.txt" > $HOME/.zsh_plugins.sh
  antibody update
}

##### PYTHON SHITE ####
function deact() {
    # get parent folder of $VIRTUAL_ENV
    parentdir="$(dirname "$VIRTUAL_ENV")"
    basename_of_parentdir="$(basename "$parentdir")"
    echo "Deactivating venv $basename_of_parentdir"
    # check if deactivate function exists
    if typeset -f deactivate > /dev/null; then
      deactivate
    fi
}

function cd() {
  PWD=$(pwd)
  builtin cd $1

  # check if $1 is a subfolder of current directory and if so do nothing
  if [[ $1 == $PWD/* ]]; then
    # check if there is a venv in the current directory
    return
  fi


  if [[ -n "$VIRTUAL_ENV" && -d ./.venv ]] ; then
    deact
    . ./.venv/bin/activate && echo "Using 🐍 python from `which python`"
  else
    if [[ -n "$VIRTUAL_ENV" ]] ; then
      deact
    elif [[ -d ./.venv ]] ; then
      . ./.venv/bin/activate && echo "Using 🐍 python from `which python`"
    fi
  fi
}

function act() {
  if [[ -n "$VIRTUAL_ENV" ]] ; then
    deact
  fi
  if [[ -d ./.venv ]] ; then
    . ./.venv/bin/activate
  else
    # Create .venv
    cur_dir_basename=$(basename $(pwd))
    python3 -m venv .venv --prompt $cur_dir_basename
  fi
  . ./.venv/bin/activate && echo "Using 🐍 python from `which python`"
}

function refreshenv() {
  if [[ -n "$VIRTUAL_ENV" ]] ; then
    rm -rf ${PWD}/.venv > /dev/null
    act
  fi
}



function get-tk-cli() {
  if [[ -z "$TK_CLI_VERSION" ]]; then
    _PWD=$(pwd)
  	RAND_TMP_FOLDER=$(mktemp -d)
    cd "$RAND_TMP_FOLDER"
    TK_RELEASE_URL=$(gh api https://api.github.com/repos/travelperk/tk-cli/releases/latest | jq -r '.assets[] | select(.name | contains("darwin_arm64")) | .browser_download_url')
    echo "Downloading latest tk-cli binary release from $TK_RELEASE_URL"
    gh release download --pattern "*darwin_arm64*" --repo "https://github.com/travelperk/tk-cli"
    mv tk* tk > /dev/null
    chmod +x tk
    mkdir -p "$HOME"/.local/bin
    mv tk "$HOME"/.local/bin/tk
    cd "$_PWD"
    rm -rf "$RAND_TMP_FOLDER" > /dev/null
    echo "tk-cli installed in $HOME/.local/bin/tk"
    tk -V
  fi
}

function recho() {
  echo -en "\033[1A\033[2K" # Rewrites previous line
  echo "$@"
}

# Puts the `export $PIP_INDEX_URL=blah` into your clipboard so you can paste it into containers
function cpip() {
  echo "export PIP_INDEX_URL=$PIP_INDEX_URL" | pbcopy
}

function wait-for-docker() {
  echo "Waiting for docker to start..."
  while ! docker ps > /dev/null 2>&1; do
    sleep 2
  done
  recho "Waiting for docker to start...DONE"
}

function dc-preflight() {
  ( set -e
    # Check if logged in to AWS
    if aws sts get-caller-identity &> /dev/null ; then
      echo "Logged in to AWS..."
    else
      tk login
    fi

    

    docker ps &> /dev/null || \
      echo "Docker is not running. Opening..." && \
      open --background -a Docker

    wait-for-docker
  )
  exit_status=$?
  if [[ $exit_status -ne 0 ]]; then exit "$exit_status"; fi
}

function _docker-compose-devcontainer() {
  command="docker-compose -f docker-compose.yml -f .devcontainer/docker-compose.yml $*"
  echo "Running $command"
  eval "$command"
}

# Vscode devcontainer goodness. Opens the devcontainer using `dc`, which is
# equivalent to `devcontainer open .`
function dc() {
  dc-preflight # Logs in to AWS if necessary, loads new PIP_INDEX_URL
  export DOCKER_BUILDKIT=1 # VSCode supports Docker's DOCKER_BUILDKIT - let's use it
  # if there are no arguments and just `dc`, we run `devcontainer open .`
  if [[ $# -eq 0 ]] ; then
    [ -f "$HOME/.config/pip/pip.conf" ] && \
      PIP_INDEX_URL=$(awk -F "= " '/index-url/ {print $2}' "$HOME/.config/pip/pip.conf")
    echo "Opening devcontainer..."
      PIP_INDEX_URL=$PIP_INDEX_URL devcontainer open . &> /dev/null && \
      recho "Opening devcontainer...DONE!"
  else
    # rather than have another alias for docker-compose we can just use `dc` for that too.
    # docker-compose commands like start/stop/restart/down
    compose_commands="buildx config create down events exec images kill logs pause port ps pull push restart rm run scale start stop top unpause up version"
    # check if the first argument is one of the above, if use run `docker-compose {command}` instead.
    # So `dc exec django bash` acts like regular `docker-compose exec bash`
    if [[ $compose_commands =~ (^|[[:space:]])"$1"($|[[:space:]]) ]]; then
      _docker-compose-devcontainer "$@"
    else
      devcontainer $@ # In case you want to use `dc build` or other devcontainer commands
      # $ devcontainer --help # should give you more context
    fi
  fi
}


##### GIT ####
alias gpu="git pushup"
alias gpv="gh pr view -w"
alias grc="git rebase --continue"
alias gmc="git merge --continue"
alias gmain="git pull --rebase origin main"
alias gmaster="git pull --rebase origin master"

function gpr() {
  git stash && \
  git pull --rebase origin "$(git remote show origin | awk '/HEAD branch:/ {print $3}')" && \
  git stash pop
}


function pr() {
  gh pr list | sk --preview "gh pr checks {+1}; gh pr view {+1}" --ansi | awk '{print $1}' | xargs gh pr checkout
}

### Alias manager

function add-alias() {
  printf "alias %s='%s'\n" "$1" "$2" >> ~/.bash_aliases
  rr
}

alias gapf='git add . && git commit --amend --no-edit && git push -f'
