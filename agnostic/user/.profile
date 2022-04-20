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
    if [[ -d "$1" ]]; then
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

add_to_path "$HOME/.local/bin"

# Pyenv
if [[ -d "$HOME/.pyenv" ]]; then
	export PYENV_ROOT="$HOME/.pyenv"
	add_to_path "$PYENV_ROOT/bin"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
fi

# Rust
export RUST_HOME="$HOME/.rust"
export RUSTUP_HOME="$RUST_HOME/rustup"
export CARGO_HOME="$RUST_HOME/cargo"
[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env"

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
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

export PATH

export REMOTE_DIR="$HOME/Code/remote"
export GITHUB_DIR="$REMOTE_DIR/github.com"
export MY_GITHUB_DIR="$GITHUB_DIR/RenoirTan"
