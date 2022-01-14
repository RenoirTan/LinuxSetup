source ../utils.sh

pre_ohmyzsh="$HOME/.zshrc.pre-oh-my-zsh"
[[ -f "$pre_ohmyzsh" ]] && mv "$pre_ohmyzsh" "$HOME/.zshrc"

