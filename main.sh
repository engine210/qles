#!/bin/bash
# cd $HOME

# Clone this repo
# git clone https://github.com/engine210/qles.git
# REPO_DIR=$HOME/qles
export REPO_DIR=/home/engine210/Desktop/Projects/qles
export BAK_DIR=$HOME/.qles_backup_tmp
export LBLUE='\033[1;34m' # Light blue
export YELLOW='\033[1;33m'
export NC='\033[0m' # No Color

TASKS=( 'zsh' 'tmux' 'vim' 'git' )

# Create a directory to backup old config
mkdir $BAK_DIR
#########################################

for i in "${TASKS[@]}"
do
    cd $REPO_DIR/tasks/$i
    bash main.sh
done


# Rename the backup directory
mv $BAK_DIR $HOME/.qles_backup_$(date "+%Y.%m.%d-%H.%M.%S")
#########################################