source ../../utils.sh

lxspr_cp /etc/pacman.d/hooks/nvidia.hook

pacman -Syu < './packages/nvidia-packages.txt'

echo "Run 'setup.sh distro/arch/enable-nvidia.sh' to setup the nvidia driver."
echo "Then, restart the computer for the changes to take effect."
