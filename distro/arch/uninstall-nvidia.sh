source ../../utils.sh

pacman -Rns nvidia

rm /etc/pacman.d/hooks/nvidia.hook

mkinitcpio -P

echo "Restart now for changes to take effect."

