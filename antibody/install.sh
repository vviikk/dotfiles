#!/bin/sh
antibody bundle < "$HOME/dotfiles/antibody/.zsh_plugins.txt" > $HOME/.zsh_plugins.sh
antibody update
