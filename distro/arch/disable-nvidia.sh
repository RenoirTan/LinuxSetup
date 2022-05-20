source ../../utils.sh

sed '/^\w*MODULES\w*=([^#)]*/ s/\s*nvidia[A-Za-z_]*//g' /etc/mkinitcpio.conf -i.old

my_working_directory=$(pwd)
cd ../../agnostic/
sh ./clean-nouveau-blacklist.sh
cd ${my_working_directory}

mkinitcpio -P
