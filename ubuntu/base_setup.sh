# install zsh
apt install zsh
# install o my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install linux brew
sudo apt install ruby
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
sudo apt install build-essential
echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' >>~/.zshrc
echo 'export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"' >>~/.zshrc
echo 'export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"' >>~/.zshrc
PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
