source ../../utils.sh

pacman -Syu reflector

lxspr_cp /etc/xdg/reflector/reflector.conf
lxspr_cp /etc/systemd/system/reflector.timer
lxspr_cp /etc/pacman.d/hooks/mirrorupgrade.hook

systemctl enable reflector
systemctl start reflector

