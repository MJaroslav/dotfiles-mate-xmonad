sudo apt install sakura -y
mkdir ${HOME}/.config/sakura/
rm ${HOME}/.config/sakura/sakura.conf
ln -sv ${HOME}/.dotfiles/sakura/sakura.conf ${HOME}/.config/sakura/sakura.conf
