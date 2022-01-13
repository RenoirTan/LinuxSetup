source ../../utils.sh

systemctl stop reflector
systemctl disable reflector

rm /etc/pacman.d/hooks/mirrorupgrade.hook
rm /etc/systemd/system/reflector.timer
rm /etc/xdg/reflector/reflector.conf

pacman -Rns reflector

