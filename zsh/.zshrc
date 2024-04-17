# neofetch
# fastfetch
# nerdfetch
showmotd

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="murilasso"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Choose between one [code, code-insiders or codium]
# The following line will make the plugin to open VS Code Insiders
# Invalid entries will be ignored, no aliases will be added
VSCODE=codium

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    vscode
    python
    nmap
    gradle
    # command-not-found
    thefuck
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# compinit
# Add .files to completion.
_comp_options+=(globdots)
# But disable .. and .
zstyle ':completion:*' special-dirs false
# And enable rehash for new installed executables
zstyle ':completion:*' rehash

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias v="nvim"
alias s="sudo"
alias fm="ranger"
alias cls="clear; showmotd"
alias git='hub'
alias xcopy='xclip -selection clipboard -i'
alias xpaste='xclip -selection clipboard -o'
alias dmenu="dmenu -nb \\#070C19 -sb \\#233875"
alias dmenu_run="dmenu_run -nb \\#070C19 -sb \\#233875"
# [ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
# Shortcuts.
alias df="cd ~/.dotfiles"
alias ws="cd ~/workspace"
alias wsg="cd ~/workspace/git"
alias sndbx="cd ~/abyss/workspace"
alias abyss="cd ~/abyss"
alias home="cd ~; cls"
# Open configurations.
alias zshconf="nvim ~/.zshrc"
alias xmdconf="nvim ~/.xmonad/xmonad.hi"
# Swap JDKs
alias jdks="sdk list java | grep -E \"(installed)|(local only)\" | cut -d \"|\" -f6 | sed -E 's/^\s*|\s*$//g'"
alias jdk8fx='sdk use java 8.0.345.fx-zulu'
alias jdk8='sdk use java 8.0.345-zulu'
alias jdk16fx='sdk use java 16.0.2.fx-zulu'
alias jdk17='sdk use java 17.0.4-zulu'
alias jdk17fx='sdk use java 17.0.4.fx-zulu'
alias usejdk='sdk use java "$(jdks | dmenu -b)"'

bindkey -s '^l' "cls\n"

# thefuck configuration
# SO SLOW
# eval $(thefuck --alias)
# eval $(thefuck --alias suka)
# eval $(thefuck --alias блять)
# eval $(thefuck --alias бля)
# eval $(thefuck --alias сука)

# Some functions and hooks
#
# Redraw with actual motd on window resize
TRAPWINCH () {
    cls
    printf '\n'
    zle reset-prompt
}
# Exit by ctrl+D with any line content
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh
# TheFuck on ctrl+F
# bindkey -s '^f' "fuck\n"

# Phone name for termux-find command 
export TERMUX_NAME="Redmi-Note-7"

# Make all java use UTF-8 encoding
export JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"
# Fix fucking AWT grey screen
export _JAVA_AWT_WM_NONREPARENTING=1

# JetBrains installed apps runners.
export PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"
# Add dotfiles bins to PATH
export PATH="$HOME/.dotfiles/bin:$PATH"

# THIST MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
[ -f "$HOME/.cabal/bin/" ] && export PATH=$HOME/.cabal/bin/:$PATH # cabal-env
