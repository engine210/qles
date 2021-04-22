#!/bin/bash
set -e

printf "${LBLUE}Copying git configutation\n${NC}"
if [ -f $HOME/.gitconfig ]; then
	mv $HOME/.gitconfig $BAK_DIR
fi
cp $REPO_DIR/tasks/git/files/.gitconfig ~/.gitconfig