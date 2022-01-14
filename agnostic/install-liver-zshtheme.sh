source ../utils.sh

repo_url="github.com/RenoirTan/liver.zsh-theme"
dest_path="$HOME/Code/remote/$repo_url"
git clone "https://$repo_url" "$dest_path"

cp "$dest_path/liver.zsh-theme" "$HOME/.oh-my-zsh/themes/liver.zsh-theme"

rm -rf "$dest_path"

