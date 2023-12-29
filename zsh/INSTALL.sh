sudo apt install zsh -y

echo "Install oh my zsh? (1/0)"
read REPLY
echo
if [ $REPLY -eq 1 ]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

rm ${HOME}/.zshrc
ln -sv ${HOME}/.dotfiles/zsh/.zshrc $HOME/.zshrc
