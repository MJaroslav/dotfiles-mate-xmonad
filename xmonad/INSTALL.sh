sudo apt install xmonad xmobar xautolock flameshot nitrogen mate-screensaver -y
mkdir ${HOME}/.xmonad/
ln -sv ${HOME}/.dotfiles/xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs
ln -sv ${HOME}/.dotfiles/xmonad/scripts ${HOME}/.xmonad/
ln -sv ${HOME}/.dotfiles/xmonad/icons ${HOME}/.xmonad/
xmonad --recompile
