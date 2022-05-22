source ../../utils.sh

OLD_PWD=$(pwd)

pacman -S --needed git base-devel
git clone "https://aur.archlinux.org/yay.git" "$HOME/Code/remote/aur.archlinux.org/yay"
cd "$HOME/Code/remote/aur.archlinux.org/yay"
makepkg -si

cd $OLD_PWD

