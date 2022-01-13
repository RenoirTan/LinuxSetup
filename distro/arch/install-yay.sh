source ../../utils.sh

OLD_PWD=$(pwd)

pacman -S --needed git base-devel
git clone "https://aur.archlinux.org/yay.git" "$HOME/Code/aur.archlinux.org/yay"
cd  "$HOME/Code/aur.archlinux.org/yay"
makepkg -si

cd $OLD_PWD

