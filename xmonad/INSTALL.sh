#!/bin/bash
echo "Installing dependencies..."
echo "Do you wish to install next apt packages: suckless-tools gmrun trayer brightnessctl caja alsa-utils xautolock flameshot nitrogen mate-screensaver libgtk2.0-dev libpango1.0-dev libglib2.0-dev libcairo2-dev"
read -p "[Yy/Nn]" yn
if [[ $yn =~ Y|y ]]; then
    sudo apt install suckless-tools gmrun trayer amixer brightnessctl caja alsa-utils xautolock flameshot nitrogen mate-screensaver libgtk2.0-dev libpango1.0-dev libglib2.0-dev libcairo2-dev -y
fi

echo "Installing xmobar by cabal"
cd ~
cabal install xmobar-0.47.2 --flags="all_extensions" --overwrite-policy=always
cd -

mkdir $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
ln -sv $HOME/.dotfiles/xmonad/scripts $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/icons $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/xmonad-config.cabal $HOME/.xmonad
ln -sv $HOME/.dotfiles/xmonad/build $HOME/.xmonad
ln -sv $HOME/.dotfiles/xmonad/xmobarrc $HOME/.xmonad
ln -sv $HOME/.dotfiles/xmonad/xmobarminirc $HOME/.xmonad

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

echo "Installing and recompiling xmonad..."
cd ~
cabal install --lib xmonad
cabal install --lib xmonad-contrib
cd -
xmonad --recompile
