#!/bin/bash
set -e

printf "${LBLUE}Copying vim configutation\n${NC}"
if [ -f $HOME/.vimrc ]; then
	mv $HOME/.vimrc $BAK_DIR
fi
cp $REPO_DIR/tasks/vim/files/.vimrc ~/.vimrc