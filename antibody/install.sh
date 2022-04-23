#!/bin/sh
antibody bundle < "$PWD/.zsh_plugins.txt" > $HOME/.zsh_plugins.sh
antibody update
