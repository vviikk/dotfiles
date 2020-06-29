#!/bin/sh

# Jason Rudolph's Keyboard 
git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard
cd ~/.keyboard
script/setup

# Neovim / Spaceneovim
brew install neovim && \                     
sudo pip3 install neovim && \
sudo pip3 install --upgrade neovim && \
../nvim/install-spaceneovim.sh

# Enable key repeat on vscode & vscode insiders
defaults delete com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
defaults delete com.microsoft.VSCode ApplePressAndHoldEnabled
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
