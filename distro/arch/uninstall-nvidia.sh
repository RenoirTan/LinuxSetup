source ../../utils.sh

pacman -Rns nvidia

lxspr_rm /etc/pacman.d/hooks/nvidia.hook

mkinitcpio -P

echo "Run 'setup.sh distro/arch/disable-nvidia.sh' to remove the nvidia driver."
echo "Then, restart the computer for the changes to take effect."
