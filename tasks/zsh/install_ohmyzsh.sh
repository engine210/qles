
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" | zsh
# 
# clone the script
rm -rf ~/myZsh
git clone https://github.com/engine210/myZsh.git ~/myZsh
# 
# install oh-my-zsh plugin
cd $HOME/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions.git
cd $HOME
# 
# edit .zshrc ( commend here, use copy .zshrc instead )
# sed -i 's/^ZSH_THEME=.*/ZSH_THEME="fishy"/g' ~/.zshrc
# sed -i 's/^plugins=.*/plugins=(\n\tgit\n\tapple\n\tbanana\n)/g' ~/.zshrc
# backup .zshrc if already exist
if [ -f $HOME/.zshrc ]; then
	mv $HOME/.zshrc $HOME/.zshrc.bak.$(date "+%Y.%m.%d-%H:%M:%S")
fi
cp ~/myZsh/.zshrc ~/.zshrc
# 
# clean up
rm -rf ~/myZsh
# 
exec zsh
# 