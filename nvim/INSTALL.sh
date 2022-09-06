sudo apt install neovim -y
mkdir ${HOME}/.config/nvim/
rm ${HOME}/.config/nvim/init.vim
sh -c 'curl -fLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -sv ${HOME}/.dotfiles/nvim/init.vim ${HOME}/.config/nvim/init.vim
