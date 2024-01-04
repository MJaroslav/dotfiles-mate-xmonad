#!bin/bash

echo "Install zsh from apt?"
read -p "[Yy/Nn]" yn
if [[ $yn =~ Y|y ]]; then
    sudo apt install zsh -y
fi

echo "Install oh my zsh? Use default installation directory."
read -p "[Yy/Nn]" yn
if [[ $yn =~ Y|y ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -f $HOME/.zshrc ]; then
    mv -v $HOME/.zshrc $HOME/.zshrc.orig
fi
ln -sv $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
