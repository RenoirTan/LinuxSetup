# Taken from arch linux /etc/profile
# This is different from the implementation in /etc/profile
# in that new paths are added to the front of the PATH
# variable instead of at the back
append_path() {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
    esac
}

add_to_path() {
    if [ -d "$1" ]; then
        append_path "$1"
    fi
}

source_path() {
    [ -f $1 ] && source $1
}

source_first() {
    while [ $# -gt 1 ]; do
        if [ -f $1 ]; then
            source $1
            return 0
        else
            shift
        fi
    done
}

tlp_watch() {
    local __elevate
    if [ ! -z $DISPLAY ]; then
        if command -v pkexec &>/dev/null; then; __elevate=pkexec; fi
    fi
    if [ -z $__elevate ]; then
        if command -v sudo &>/dev/null; then; __elevate=sudo
        elif command -v doas &>/dev/null; then; __elevate=doas
        else
            echo "No suitable setuid program found"
            exit 1
        fi
    fi

    if ! command -v watch &>/dev/null; then
        echo "watch not found"
        exit 1
    fi

    if ! command -v tlp-stat &>/dev/null; then
        echo "tlp-stat not found"
        exit 1
    fi

    ${__elevate} watch tlp-stat -b
}

add_to_path "$HOME/.local/bin"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
activate_pyenv() {
    if command -v pyenv &>/dev/null; then
    #    add_to_path "$PYENV_ROOT/bin"
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    fi
}

# Rust
export RUST_HOME="$HOME/.rust"
export RUSTUP_HOME="$RUST_HOME/rustup"
export CARGO_HOME="$RUST_HOME/cargo"
activate_rust() {
    [ -f "$CARGO_HOME/env" ] && source "$CARGO_HOME/env"
}

# Go
export GOPATH="$HOME/Code/languages/go"
add_to_path "$GOPATH/bin"

# Wine
export WINE_BOTTLE_PATH="$HOME/Wine"
export WINEARCH="win64"
export WINEPREFIX="$WINE_BOTTLE_PATH/General"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
activate_sdkman() {
    [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

export PATH

export EDITOR="nvim"
export MAKEFLAGS="-j8"
export REMOTE_DIR="$HOME/Code/remote"
export GITHUB_DIR="$REMOTE_DIR/github.com"
export MY_GITHUB_DIR="$GITHUB_DIR/RenoirTan"
export LINUX_SCM_DIR="$REMOTE_DIR/git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux"
