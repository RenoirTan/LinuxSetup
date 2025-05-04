# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

[[ -f "$HOME/.profile" ]] && source "$HOME/.profile"

#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

erase_history() {
	local HISTSIZE="${1:-0}"
    rm -f $HOME/.zsh_history
}

quit() {
    erase_history "$1"
    exit
}

syntax_highlighting() {
    source_path "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
}

autosuggestions() {
    source_path "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
}

safe_neofetch() {
    command -v neofetch > /dev/null && neofetch --disable gpu
}

cat_motd() {
    [ -f '/etc/motd' ] && cat '/etc/motd'
    [ -d '/etc/motd.d' ] && cat '/etc/motd.d/'*
}

# Path to your oh-my-zsh installation.
export ZSH="/home/renoir/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#export ZL_LEFTUPBEGIN=┌
#export ZL_LEFTDOWNBEGIN=└
#export ZL_RIGHTUPBEGIN=┐
export ZL_RIGHTDOWNBEGIN=─┘
export ZL_USERNAME_ICON=󱗆
export ZL_HOSTNAME_ICON=󱓟
export ZL_PATH_ICON=󰞁
#export ZL_VCSSYSTEM_ICON=
#export ZL_VCSBRANCH_ICON=
#export ZL_VCSPATH_ICON=
#export ZL_VCSMETA_ICON=󱔢
export ZL_USER_PROMPTTOKEN=λ
#export ZL_SEGMENTLEFT='['
#export ZL_SEGMENTRIGHT=']'
#export ZL_PROMPTPOINTER=󰈸
#export ZL_VCSSYSTEM_DEC="$(zl_make_decoration 197 ! !)"
#export ZL_VCSBRANCH_DEC="$(zl_make_decoration 214 ! ! )" 
#export ZL_VCSPATH_DEC="$(zl_make_decoration 46 ! ! )"
#export ZL_VCSMETA_DEC="$(zl_make_decoration 62 ! !)"
ZSH_THEME="liver"

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

_os_name=$(awk -F'=' '/^NAME=/ {print $2}' /etc/*-release | cut -c 2- | rev | cut -c 2- | rev)

if ! tty | grep -E 'tty[0-9]*$' >/dev/null ; then
    echo '\e[1m\e[1;36m'
    echo "${_os_name} $(uname -r) ($(tty | cut -c 6-))"
    echo ''
    cat_motd
fi
echo -n '\e[0m'
#safe_neofetch
autosuggestions
syntax_highlighting
