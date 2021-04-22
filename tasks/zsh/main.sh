#!/bin/bash
LBLUE='\033[1;34m' # Light blue
YELLOW='\033[1;33m'
NC='\033[0m' # No Color


printf "${LBLUE}Configuring zsh\n${NC}"

# Check if zsh exist, if not, install from source
if [[ -z "$(grep zsh /etc/shells)" ]]; then
	printf "${YELLOW}zsh not found\n${NC}"
	cd $REPO_DIR/tasks/zsh
	source install_zsh.sh # use source since inside script will modified PATH
elif [[ "$(basename $SHELL)" != "zsh" ]]; then
	chsh -s $(grep zsh /etc/shells)
fi

printf "${LBLUE}Installing oh-my-zsh\n${NC}"
echo $PATH
cd $REPO_DIR/tasks/zsh
bash install_ohmyzsh.sh
printf "Done install oh-my-zsh\n"