alias gg=googler
alias ZZ=exit
alias ls-scripts='echo $(node -p -e "JSON.stringify(require(process.cwd()+\"/package.json\").scripts)") | jq '.' || python -m json.tool || cat'

alias v=nvim
alias vim=nvim
alias abl='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'

# alias for copy move and remove
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# copy the public key
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

eval $(thefuck --alias f)

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
alias dex="docker exec -i -t"

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

alias cat=bat
# alias cd='pushd'
# alias back='popd'
# alias flip='pushd_builtin'
alias r='ranger'

alias git=hub
# eval "$(hub alias -s)"

function gitsearch()
{
   searchCrit='stash\|'$1
   git stash list | while IFS=: read STASH ETC; do echo "$STASH: $ETC"; git diff --stat $STASH~..$STASH --; done | grep -e $searchCrit
}
alias githunt=gitsearch

# # this is for even-better-ls
# LS_COLORS=$(ls_colors_generator)

# run_ls() {
# 	ls-i --color=auto -w $(tput cols) "$@"
# }

# run_dir() {
# 	dir-i --color=auto -w $(tput cols) "$@"
# }

# run_vdir() {
# 	vdir-i --color=auto -w $(tput cols) "$@"
# }
# alias ls="run_ls"
# alias dir="run_dir"
# alias vdir="run_vdir"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
