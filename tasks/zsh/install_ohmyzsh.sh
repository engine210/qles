#!/bin/bash
set -e

# install oh-my-zsh
printf "Executing oh-my-zsh install script\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed '/exec zsh*/d')"

# install oh-my-zsh plugin
printf "Cloning plugins..."
cd $HOME/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git &> /dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions.git &> /dev/null
cd $HOME
printf "done\n"


if [ -f $HOME/.zshrc ]; then
	mv $HOME/.zshrc $BAK_DIR
fi
cp $REPO_DIR/tasks/zsh/files/.zshrc ~/.zshrc