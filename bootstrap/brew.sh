#!/usr/bin/env bash

# Exit on any error
set -e

# Check to see if Homebrew is installed, and install it if it is not
which -s brew
if [[ $? != 0 ]] ; then
  # Install Homebrew
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  # Make sure we’re using the latest Homebrew.
  brew update
  # Upgrade any already-installed formulae.
  brew upgrade
fi

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install zsh and zsh completions
brew install zsh zsh-completions zsh-autosuggestions
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install tmux
brew install neovim
brew install grep
brew install openssh
brew install curl

# Install other useful binaries.
brew install the_silver_searcher
brew install fzf
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli

# Dev addons
brew install yarn --without-node

# Remove outdated versions from the cellar.
brew cleanup