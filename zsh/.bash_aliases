autoload bashcompinit
bashcompinit


alias gg=googler
alias ZZ=exit
alias ls-scripts='echo $(node -p -e "JSON.stringify(require(process.cwd()+\"/package.json\").scripts)") | jq '.' || python -m json.tool || cat'

alias v=nvim
alias vim=nvim
alias abl='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'
alias ssh="TERM=xterm ssh"

# alias for copy move and remove
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

if command -v exa &> /dev/null
then
  alias exa='exa --icons'
else
  unalias ls
fi

# copy the public key
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

[ -e  thefuck ] && eval $(thefuck --alias f)

ghp() {
  git clone https://github.com/$1.git
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

# pushd()
# {
#   if [ $# -eq 0 ]; then
#     DIR="${HOME}"
#   else
#     DIR="$1"
#   fi

#   builtin pushd "${DIR}" > /dev/null
#   echo -n "DIRSTACK: "
#   dirs
# }

# pushd_builtin()
# {
#   builtin pushd > /dev/null
#   echo -n "DIRSTACK: "
#   dirs
# }

# popd()
# {
#   builtin popd > /dev/null
#   echo -n "DIRSTACK: "
#   dirs
# }
if command -v bat &> /dev/null
then
  alias cat=bat
fi
# alias cd='pushd'
# alias back='popd'
# alias flip='pushd_builtin'
alias r='ranger'
alias emulator='~/Library/Android/sdk/emulator/emulator' 

[[ -f .bash_secrets ]] && source .bash_secrets

export AWS_SDK_LOAD_CONFIG=1  # Load the AWS_PROFILE in terraform calls

# alias git=hub
[ -e hub ] && eval "$(hub alias -s)"

function sshake() {
  ssh-copy-id -i ~/.ssh/id_rsa.pub $1
}

function pi() {
  ssh pi@pi $@
}

function pidc() {
  ssh pi@pi "docker-compose $@"
}

function pil() {
  ssh pi@pi "docker-compose logs -f $@"
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
WORK_SRC="/home/vik/work/tk-meta"

gt() {
    if [[ -e $WORK_SRC/$1 ]]; then
        cd $WORK_SRC/$1
    else
        print "there is no such project: $1"
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

antibodyinit() {
  antibody bundle < "$HOME/dotfiles/antibody/.zsh_plugins.txt" > $HOME/.zsh_plugins.sh
  antibody update
}

##### PYTHON SHITE ####
function cd() {
  builtin cd $1

  if [[ -n "$VIRTUAL_ENV" && -d ./.venv ]] ; then
    deactivate
    . ./.venv/bin/activate # && echo "Using 🐍 python from `which python`"
  fi
}

##### GIT ####
alias grc="git rebase --continue"
alias gmc="git merge --continue"
alias gm="git pull --rebase origin main"



### FASD ###
# fasd {{{
# =====
if _has fasd; then
    fasd_cache="$ZSH_CACHE_DIR/fasd-init-cache"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
	fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
    fi
    . "$fasd_cache"
    unset fasd_cache
fi
# }}}
#

# If fasd is installed and in use, add a bunch of
# aliases for it.
if command -v fasd >/dev/null 2>&1; then
    # Any
    alias a='fasd -a'

    # Show/search/select
    alias s='fasd -si'

    # Directory
    alias d='fasd -d'

    # File
    alias f='fasd -f'

    # Interactive directory selection
    alias sd='fasd -sid'

    # Interactive file selection
    alias sf='fasd -sif'

    # cd - same functionality as j in autojump
    alias z='fasd_cd -d'

    # Interactive cd
    alias zz='fasd_cd -d -i'

    # Vim
    alias v='fasd -f -e vim'
fi
