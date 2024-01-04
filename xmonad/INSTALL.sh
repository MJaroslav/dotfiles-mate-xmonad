#!/bin/bash
echo "Installing dependencies..."
echo "Do you wish to install next apt packages: xmobar suckless-tools gmrun trayer amixer brightnessctl caja alsa-utils xautolock flameshot nitrogen mate-screensaver"
read -p "[Yy/Nn]" yn
if [[ $yn =~ Y|y ]]; then
    sudo apt install xmobar suckless-tools gmrun trayer amixer brightnessctl caja alsa-utils xautolock flameshot nitrogen mate-screensaver -y
fi

mkdir $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
ln -sv $HOME/.dotfiles/xmonad/scripts $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/icons $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/xmonad-config.cabal $HOME/.xmonad
ln -sv $HOME/.dotfiles/xmonad/build $HOME/.xmonad
ln -sv $HOME/.dotfiles/xmonad/xmobarrc $HOME/.xmonad

echo "Do you wish add xsession to LightDM (or analogue)?"
read -p "[Yy/Nn]" yn
if [[ $yn =~ Y|y ]]; then
    sudo cp -v $HOME/.dotfiles/xmonad/xmonad.desktop /usr/share/xsessions/
    sudo cp -v $HOME/.dotfiles/xmonad/xmonad-start.sh /usr/share/xsessions/

    echo "Do you wish add XMonad icon to LightDM (or analogue)?"
    read -p "[Yy/Nn]" yn
    if [[ $yn =~ Y|y ]]; then
        sudo cp -v $HOME/.dotfiles/xmonad/xmonad.svg /usr/share/icons/hicolor/scalable/places/xmonad_badge-symbolic.svg
    fi
fi

echo "Recompiling xmonad..."
xmonad --recompile
