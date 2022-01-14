source ../utils.sh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Oh My Zsh hasn't been installed yet!"
	exit 1
fi

lxsp_cp ".zshrc"
# If the liver theme exists, use the liver theme
[[ -f "$HOME/.oh-my-zsh/themes/liver.zsh-theme" ]] && echo "ZSH_THEME=\"liver\"" >> "$HOME.zshrc"

