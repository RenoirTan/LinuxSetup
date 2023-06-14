source ../utils.sh

OLD_PWD=$(pwd)
REPO_DIR="${HOME}/Code/remote/github.com/RenoirTan/NeovimSetup"
NVIM_CONF_DIR="${HOME}/.config/nvim"

lxsp_backup ".config/nvim"
git clone 'https://github.com/RenoirTan/NeovimSetup' "${REPO_DIR}"
mkdir -p "${NVIM_CONF_DIR}"
ln -sf "${REPO_DIR}/init.lua" "${NVIM_CONF_DIR}/init.lua"

echo "Open neovim to begin setup, make sure you have an internet connection."

cd $OLD_PWD
