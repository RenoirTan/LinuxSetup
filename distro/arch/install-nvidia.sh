source ../../utils.sh

lxspr_cp /etc/pacman.d/hooks/nvidia.hook

pacman -Syu nvidia

echo "Restart now for changes to take effect."

