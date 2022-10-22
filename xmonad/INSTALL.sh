sudo apt install xmonad xmobar xautolock nitrogen mate-screensaver -y
mkdir ${HOME}/.xmonad/
ln -sv ${HOME}/.dotfiles/xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs
ln -sv ${HOME}/.dotfiles/xmonad/xmobar ${HOME}/.xmonad/
xmonad --recompile
