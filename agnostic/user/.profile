# Pyenv
if [[ -d "$HOME/.pyenv" ]]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
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
[[ -d "$GOPATH/bin" ]] && export PATH="$GOPATH/bin:$PATH"

# Wine
export WINE_BOTTLE_PATH="$HOME/Wine"
export WINEARCH="win64"
export WINEPREFIX="$WINE_BOTTLE_PATH/General"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
