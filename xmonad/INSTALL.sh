sudo apt install xmonad xmobar xautolock nitrogen mate-screensaver -y
mkdir ${HOME}/.xmonad/
rm ${HOME}/.xmonad/xmonad.hs
mkdir ${HOME}/.xmonad/xmobar/
rm ${HOME}/.xmonad/xmobar/xmobarrc
ln -sv ${HOME}/.dotfiles/xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs
ln -sv ${HOME}/.dotfiles/xmonad/xmobar/xmobarrc ${HOME}/.xmonad/xmobar/xmobarrc
xmonad --recompile
