source ../../utils.sh

pacman -Rns nvidia

lxspr_rm /etc/pacman.d/hooks/nvidia.hook

mkinitcpio -P

echo "Restart now for changes to take effect."

