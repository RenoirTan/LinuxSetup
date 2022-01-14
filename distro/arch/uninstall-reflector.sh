source ../../utils.sh

systemctl stop reflector
systemctl disable reflector

lxspr_rm /etc/pacman.d/hooks/mirrorupgrade.hook
lxspr_rm /etc/systemd/system/reflector.timer
lxspr_rm /etc/xdg/reflector/reflector.conf

pacman -Rns reflector

