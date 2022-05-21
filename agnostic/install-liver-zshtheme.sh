source ../utils.sh

repo_url="github.com/RenoirTan/liver.zsh-theme"
dest_path="$HOME/Code/remote/$repo_url"
git clone "https://$repo_url" "$dest_path"

cp "$dest_path/liver.zsh-theme" "$HOME/.oh-my-zsh/themes/liver.zsh-theme"

echo -n "Do you want to delete the local git repository? (y/n)"
read reply
if [ $reply == "y" ]; then
    echo "Removing '$dest_path'"
    rm -rf "$dest_path"
else
    echo "Not removing '$dest_path'"
fi
