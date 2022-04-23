#!/usr/bin/env sh
echo
echo "Installing ZSH & Antibody"
echo

check_dist() {
    (
        . /etc/os-release
        echo $ID
    )
}

check_version() {
    (
        . /etc/os-release
        echo $VERSION_ID
    )
}

install_dependencies() {
    DIST=`check_dist`
    VERSION=`check_version`
    echo "###### Installing dependencies for $DIST"

    if [ "`id -u`" = "0" ]; then
        Sudo=''
    elif which sudo; then
        Sudo='sudo'
    else
        echo "WARNING: 'sudo' command not found. Skipping the installation of dependencies. "
        echo "If this fails, you need to do one of these options:"
        echo "   1) Install 'sudo' before calling this script"
        echo "OR"
        echo "   2) Install the required dependencies: git curl zsh"
        return
    fi

    case $DIST in
        alpine)
            $Sudo apk add --update --no-cache bash git curl zsh stow openssh openssl fzf shadow bat &> /dev/null && printf "PASS\nPASS" | passwd
            echo "PASS" | chsh -s $(which zsh)
        ;;
        centos | amzn)
            $Sudo yum update -y
            $Sudo yum install -y git curl stow fzf &> /dev/null
            $Sudo yum install -y ncurses-compat-libs # this is required for AMZN Linux (ref: https://github.com/emqx/emqx/issues/2503)
            $Sudo curl http://mirror.ghettoforge.org/distributions/gf/el/7/plus/x86_64/zsh-5.1-1.gf.el7.x86_64.rpm > zsh-5.1-1.gf.el7.x86_64.rpm
            $Sudo rpm -i zsh-5.1-1.gf.el7.x86_64.rpm
            $Sudo rm zsh-5.1-1.gf.el7.x86_64.rpm
        ;;
        *)
            $Sudo apt-get update
            $Sudo apt-get -qq -y install git curl zsh locales stow fzf
            if [ "$VERSION" != "14.04" ]; then
                $Sudo apt-get -y install locales-all
            fi
            $Sudo locale-gen en_US.UTF-8
            chsh -s $(which zsh)
    esac
}

change_to_zsh() {
    echo "Changing shell to zsh..."
    rm ~/.profile
    rm ~/.zshrc
    stow zsh
    if [ -z REMOTE_CONTAINERS_IPC ]
    then
        SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
            && echo $SNIPPET >> "/root/.zshrc"
    fi
    echo -e '\e[1A\e[KChanging shell to zsh...DONE'
}

install_plugins() {
    echo "Installing plugins..."
    cd antibody
    curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
    ./install.sh
    cd ..
    echo -e '\e[1A\e[KInstalling plugins...DONE'
}

install_starship() {
    echo "🚀 Installing starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    echo -e '\e[1A\e[K🚀 Installing starship prompt...DONE'
}

install_dependencies
change_to_zsh
install_plugins
install_starship

curl -o /bin/pfetch https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch && chmod +x /bin/pfetch



zsh -c 'pfetch'

exec zsh