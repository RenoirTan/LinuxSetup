# IBus
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

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

run_command() {
    echo -n " \e[1;32m$\e[0m "
    echo $@
    $@
}

get_elevate() {
    _help=0
    _gui=0
    _terminal=0
    _force=0
    _opterror=0
    while [ $# -gt 0 ]; do
        if [[ $1 =~ '^-([hgtf])*h([hgtf])*$' ]] || [ $1 = '--help' ]; then
            _help=1
        elif [[ $1 =~ '^-([hgtf])*g([hgtf])*$' ]] || [ $1 = '--gui' ]; then
            _gui=1
        elif [[ $1 =~ '^-([hgtf])*t([hgtf])*$' ]] || [ $1 = '--terminal' ]; then
            _terminal=1
        elif [[ $1 =~ '^-([hgtf])*f([hgtf])*$' ]] || [ $1 = '--force' ]; then
            _force=1
        else
            _help=1
            _opterror=1
            break
        fi
        shift
    done
    if [ $_opterror -eq 1 ]; then
        printf '\e[31mUnrecognised argument:\e[0m %q\n' $1
    fi
    if [ $_gui -eq 1 ] && [ $_terminal -eq 1 ]; then
        echo '\e[31mCannot use --gui and --terminal at the same time\e[0m\n'
        _help=1
        _opterror=1
    fi

    # 0: GUI
    # 1: Terminal
    _default_type=0
    if [[ $GET_ELEVATE =~ '^[01]$' ]]; then
        _default_type=$GET_ELEVATE
    elif [ ! -z $GET_ELEVATE ]; then
        echo '\e[31mVariable GET_ELEVATE must be '0', '1' or empty.\e[0m\n'
        _help=1
        _opterror=1
    fi

    if [ $_help -eq 1 ]; then
        echo 'Usage: get_elevate [OPTIONS]'
        echo 'OPTIONS:'
        echo '  -h, --help     -> Show this help message'
        echo '  -g, --gui      -> Only search for GUI options'
        echo '  -t, --terminal -> Only search for terminal-safe options'
        echo '  -f, --force    -> Force search filters'
        echo ''
        echo 'ENVIRONMENT VARIABLES:'
        echo '  GET_ELEVATE    -> Set what kind of permission elevator to'
        echo '                 -> choose by default.'
        echo '                 -> 0 for GUI,'
        echo '                 -> 1 for terminal.'
        return $_opterror
    fi

    _do_gui=0
    [ ! -z $DISPLAY ] && [ $_default_type -eq 0 ] && [ $_terminal -eq 0 ] && _do_gui=1
    [ $_gui -eq 1 ] && [ ! -z $DISPLAY ] || [ $_force -eq 1 ] && _do_gui=1
    _do_term=0
    [ $_gui -eq 0 ] || [ $_default_type -eq 1 ] && _do_term=1
    [ $_terminal -eq 1 ] && [ $_force -eq 1 ] && _do_term=1

    elevate=''
    if [ $_do_gui -eq 1 ]; then
        if command -v pkexec &>/dev/null; then
            elevate=pkexec
        elif command -v gksu &>/dev/null; then
            elevate=gksu
        fi
    elif [ $_do_term -eq 1 ]; then 
        if command -v sudo &>/dev/null; then
            elevate=sudo
        elif command -v doas &>/dev/null; then
            elevate=doas
        fi
    fi
    if [ -z ${elevate} ]; then
        echo "No suitable privilege elevator found"
        return 1
    fi
    echo ${elevate}
}

tlp_watch() {
    __elevate=$(get_elevate)
    if [ $? -ne 0 ]; then
        echo ${__elevate}
        return 1
    fi

    if ! command -v watch &>/dev/null; then
        echo "watch not found"
        return 1
    fi

    if ! command -v tlp-stat &>/dev/null; then
        echo "tlp-stat not found"
        return 1
    fi

    ${__elevate} watch -n 1 tlp-stat -b
}

nbfc_watch() {
    __elevate=$(get_elevate)
    if [ $? -ne 0 ]; then
        echo ${__elevate}
        return 1
    fi

    if ! command -v watch &>/dev/null; then
        echo "watch not found"
        return 1
    fi

    if ! command -v nbfc &>/dev/null; then
        echo "nbfc not found"
        return 1
    fi

    ${__elevate} watch -n 1 nbfc status --all
}

paru_do() {
    if ! command -v paru &>/dev/null; then
        echo "paru not found"
        return 1
    fi

    if [[ "$1" =~ -.+ ]]; then
        base_opt="$1"
        shift
    elif [[ $# -eq 0 ]]; then
        base_opt='-Syuv'
    else
        base_opt=''
    fi

    __elevate=$(get_elevate)
    if [ $? -ne 0 ]; then
        echo ${__elevate}
        return 1
    fi

    run_command paru "${base_opt}" --nokeepsrc --sudo="${__elevate}" $@
    if [ $? -ne 0 ]; then
        echo "Paru failed"
        return 1
    fi

    run_command ${__elevate} paccache -rk 2
    if [ $? -ne 0 ]; then
        echo "Paccache failed"
        return 1
    fi
}

add_to_path "$HOME/.local/bin"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
activate_pyenv() {
    if [ -d "$PYENV_ROOT/bin" ]; then
        add_to_path "$PYENV_ROOT/bin"
    fi
    if command -v pyenv &>/dev/null; then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
    fi
}

# Pipx
activate_pipx() {
    eval "$(register-python-argcomplete pipx)"
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
activate_wine_general() {
    export WINE_BOTTLE_PATH="$HOME/Wine"
    export WINEARCH="win64"
    export WINEPREFIX="$WINE_BOTTLE_PATH/General"
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
activate_sdkman() {
    [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

# npm
activate_npm() {
    export NODE_PATH="$HOME/.local/lib/node_modules:$NODE_PATH"
    export npm_config_prefix="$HOME/.local"
}

# Ruby
activate_ruby() {
    export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
    add_to_path "$GEM_HOME/bin"
    export PATH
}

# Rbenv
activate_rbenv() {
    eval "$(~/.rbenv/bin/rbenv init - zsh)"
}

# Jupyter
activate_jupyter() {
    export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab
}

# OCaml
activate_ocaml() {
    eval $(opam env)
}

# R
activate_rlang() {
    export R_LIBS_USER="${XDG_DATA_HOME:-$HOME/.local/share}/R/%p-library/%v"
}

# Haskell
activate_ghcup() {
    [ -f "/home/renoir/.ghcup/env" ] && . "/home/renoir/.ghcup/env" # ghcup-env
}

export PATH

export GET_ELEVATE=1
export EDITOR="nvim"
export MAKEFLAGS="-j8"
export REMOTE_DIR="$HOME/Code/remote"
export GITHUB_DIR="$REMOTE_DIR/github.com"
export MY_GITHUB_DIR="$GITHUB_DIR/RenoirTan"
export LINUX_SCM_DIR="$REMOTE_DIR/git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux"

activate_wine_general
