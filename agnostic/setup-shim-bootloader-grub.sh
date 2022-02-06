source ../utils.sh


required_exec="openssl;sbsign;sbverify;grub-install;find;sh"
for executable in $(lxsp_split_str "$required_exec" ";"); do
    if [ $(lxsp_command_exists "$executable") == "0" ]; then
        echo "Could not find $executable"
        exit 1
    fi
done


keys_dir="/etc/efi-keys"
mok_key="$keys_dir/MOK.key"
mok_crt="$keys_dir/MOK.crt"
mok_cer="$keys_dir/MOK.cer"
shim_dir="/usr/share/shim-signed"
shimx64_efi="$shim_dir/shimx64.efi"
mmx64_efi="$shim_dir/mmx64.efi"


for filepath in $(lxsp_split_str "$mok_key;$mok_crt;$mok_cer;$shimx64_efi;$mmx64_efi" ";"); do
    if [ $(lxsp_path_exists "$filepath") == "0" ]; then
        echo "Could not find $filepath"
        echo "Please run ./setup.sh agnostic/setup-machine-owner-keys.sh"
    fi
done


echo -n "Where is grub installed? "
read grub_dir
grubx64_efi="$grub_dir/grubx64.efi"


if [ ! -f "$grubx64_efi" ]; then
    echo "$grubx64_efi does not exist"
    echo "Are you sure GRUB is installed in $grub_dir?"
    exit 1
fi


cp "$shimx64_efi" "$grub_dir/shimx64.efi"
cp "$mmx64_efi" "$grub_dir/mmx64.efi"


echo -n "Label used by shim bootloader (e.g. Shim): "
read shim_label
echo -n "Drive where shim is installed (e.g. /dev/sda or /dev/nvme0n1): "
read shim_drive
echo -n "Partition where shim is installed (e.g. a or 1): "
read shim_partition


find /boot/ -maxdepth 1 -name 'vmlinuz-*' -exec sh -c "sbsign --key $mok_key --cert $mok_crt --output {} {}" ";"
sbsign --key "$mok_key" --cert "$mok_crt" --output "$grubx64_efi" "$grubx64_efi"


cp "$mok_cer" "$grub_dir/MOK.cer"
