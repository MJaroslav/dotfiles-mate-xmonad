# <img src="xmonad.svg" width="40"> XMonad

It's README file for users that not wish install ALL by [INSTALL.sh](INSTALL.sh).

I used [XMonad](https://xmonad.org/) as window manager over [MATE](https://mate-desktop.org/) desktop environment.

## Install

TODO: List all it

```bash
sudo apt install xmobar suckless-tools gmrun trayer amixer brightnessctl caja alsa-utils xautolock flameshot nitrogen mate-screensaver -y
```

Don't install XMonad from `apt`, I use `Hackage` packages by `cabal` with custom build script.

For install cabal use [ghcup](https://www.haskell.org/ghcup/install/):

```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

Link this .dotfiles to xmonad config directory:

```bash
mkdir $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/xmonad.hs $HOME/.xmonad/xmonad.hs
ln -sv $HOME/.dotfiles/xmonad/scripts $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/icons $HOME/.xmonad/
ln -sv $HOME/.dotfiles/xmonad/xmonad-config-cabal $HOME/.xmonad
```

You should create session shortcut for your session magager. For LightDM (and analogues) use it:

```bash
sudo cp -v $HOME/.dotfiles/xmonad/xmonad.desktop /usr/share/xsessions/
sudo cp -v $HOME/.dotfiles/xmonad/xmonad-start.sh /usr/share/xsessions/
```

You can also add icon for this shortcut:

```bash
sudo cp -v $HOME/.dotfiles/xmonad/xmonad.svg /usr/share/icons/hicolor/scalable/places/xmonad_badge-symbolic.svg
```

Don't forget compile XMonad before launch!

```bash
xmonad --recompile
```

This XMonad configuration ready for use now.
