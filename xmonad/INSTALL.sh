sudo apt install xmonad xmobar xautolock nitrogen mate-screensaver -y
mkdir ${HOME}/.xmonad/
rm ${HOME}/.xmonad/xmonad.hs
ln -sv ${HOME}/.dotfiles/xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs
ln -sv ${HOME}/.dotfiles/xmonad/xmobarrc ${HOME}/.xmonad/xmobarrc
xmonad --recompile
