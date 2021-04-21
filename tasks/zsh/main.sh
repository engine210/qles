#!/bin/bash
echo 'Configuring zsh...'

# backup .zshrc if already exist
# if [ -f $HOME/.zshrc ]; then
# 	mv $HOME/.zshrc $1
# fi

# Check if zsh exist, if not, install from source
if [[ ! $(basename $SHELL) == 'zsh' ]]; then
	echo lalala
fi
# if [[ -x $(command -v zsh)]]