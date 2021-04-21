#!/bin/bash
TASKS=( 'zsh' 'tmux' 'vim' )


# Create a folder to backup old config
BAK_FOLDER=$HOME/qles_backup_$(date "+%Y.%m.%d-%H.%M.%S")
mkdir $BAK_FOLDER

for i in "${TASKS[@]}"
do
    bash ./tasks/$i/$i.sh $BAK_FOLDER
done