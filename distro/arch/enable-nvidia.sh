source ../../utils.sh

# Add nvidia stuff to mkinitcpio
sed 's/^\s*MODULES\s*=([^#)]*/& nvidia nvidia_modeset nvidia_uvm nvidia_drm/' \
    /etc/mkinitcpio.conf -i.old

my_working_directory=$(pwd)
cd ../../agnostic/
sh ./setup-nouveau-blacklist.sh
cd ${my_working_directory}

mkinitcpio -P
