source ../utils.sh

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

lxsp_replace .vimrc
lxsp_replace .config/nvim/init.vim

echo "Open a new neovim session and run ':PlugInstall'."

