#!/bin/bash
set -e

printf "${LBLUE}Copying tmux configutation\n${NC}"
if [ -f $HOME/.tmux.conf ]; then
	mv $HOME/.tmux.conf $BAK_DIR
fi
cp $REPO_DIR/tasks/tmux/files/.tmux.conf ~/.tmux.conf