source ../utils.sh

curl -fLo '~/.vim/autoload/plug.vim' --create-dirs \
    'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

lxsp_replace ".vimrc"

echo "Open a new vim session and run ':PlugInstall'."

