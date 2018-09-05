# vim: set filetype=sh :

extract () {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|dmg>"
  else
    if [ -f $1 ] ; then
      # NAME=${1%.*}
      # mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2)   tar xvjf ../$1    ;;
        *.tar.gz)    tar xvzf ../$1    ;;
        *.tar.xz)    tar xvJf ../$1    ;;
        *.lzma)      unlzma ../$1      ;;
        *.bz2)       bunzip2 ../$1     ;;
        *.dmg)       hdiutil mount $1  ;;
        *.rar)       unrar x -ad ../$1 ;;
        *.gz)        gunzip ../$1      ;;
        *.tar)       tar xvf ../$1     ;;
        *.tbz2)      tar xvjf ../$1    ;;
        *.tgz)       tar xvzf ../$1    ;;
        *.zip)       unzip ../$1       ;;
        *.Z)         uncompress ../$1  ;;
        *.7z)        7z x ../$1        ;;
        *.xz)        unxz ../$1        ;;
        *.exe)       cabextract ../$1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}


inform () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}


type -P terminal-notifier &>/dev/null || return

function notify() {
  local title="$1"
	local subtitle="$2"
	shift 2
	terminal-notifier -activate com.googlecode.iterm2 -title "$title" -subtitle "$subtitle" -message "$*"
}

function notifyAndSay() {
  notify "$@"
	say "$@"
}
