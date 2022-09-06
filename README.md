# dotfiles-mate-xmonad

dotfiles for my linux mint MATE/xmonad configuration.

**Warning: This dotfiles can contain files that specific only for my system.**

## Requirements

- xmonad required screensaver from MATE DE
- some of configurations required UbuntuMono NERD font version

## Installation

Just clone this repo to home with .dotfiles directory name and run `INSTALL.sh` for all required apps.

For alias, add this to end of `~/.bash_alias`:

```bash
if [[ -f "${HOME}/.dotfiles/.bash_aliases_extended" ]]; then
	source ${HOME}/.dotfiles/.bash_aliases_extended
fi
```

