source ../../utils.sh

lxspr_cp /etc/pacman.d/hooks/nvidia.hook

pacman -Syu < './packages/nvidia-packages.txt'

echo "Restart now for changes to take effect."

