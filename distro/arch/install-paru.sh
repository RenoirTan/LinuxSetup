source ../../utils.sh

OLD_PWD=$(pwd)

pacman -S --needed git base-devel
git clone "https://aur.archlinux.org/paru.git" "$HOME/Code/remote/aur.archlinux.org/paru"
cd "$HOME/Code/remote/aur.archlinux.org/paru"
makepkg -si

cd $OLD_PWD
