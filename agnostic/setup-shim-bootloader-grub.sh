source ../utils.sh


required_exec="openssl;sbsign;sbverify;grub-install;efibootmgr;find;sh"
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
        echo "or copy your Machine Owner Keys to '/etc/efi-keys' and then"
        echo "rename them to 'MOK.key', 'MOK.crt' and 'MOK.cer' where appropriate."
    fi
done

echo -n "Where is the EFI partition mounted? "
read efi_mount
efi_mount=$(echo $efi_mount | sed -r 's/\/*$//')
if [ ! -d "$efi_mount" ]; then
    echo "'$efi_mount' could not be found!"
    echo "Are you sure your EFI partition is mounted there?"
    exit 1
fi
echo -n "Where is GRUB EFI file installed? (e.g. /boot/efi/EFI/GRUB/grubx64.efi) "
read grub_efi_file
if [ ! -f "$grub_efi_file" ]; then
    echo "'$grub_efi_file' could not be found!"
    echo "Are you sure GRUB is installed there?"
    exit 1
fi


echo -n "What name do you want to use for shim? (e.g. Shim) "
read shim_label
if [ -z "$shim_label" ]; then
    echo "No name given for shim bootloader. Defaulting to 'Shim'."
    shim_label="Shim"
fi
echo -n "Which DRIVE should shim be installed to? (e.g. /dev/sda or /dev/nvme0n1) "
read shim_drive
if [ ! -b "$shim_drive" ]; then
    echo "'$shim_drive' is not a block file!"
    exit 1
fi
echo -n "Which PARTITION should shim be installed to?  (e.g. 1 like in /dev/sdb1) "
read shim_partition
if [ -z "$shim_partition" ]; then
    echo "No partition given. Aborting!"
    exit 1
fi
shim_install_dir="$(dirname $grub_efi_file)"
echo "Shim will be installed under '$shim_install_dir/'."
echo -n "If this does not clash with other bootloaders, enter 'y': "
read reply
if [ $reply != 'y' ]; then
    echo "Aborting!"
    exit 1
fi


mkdir -p "$shim_install_dir"
cp "$shimx64_efi" "$shim_install_dir/BOOTx64.EFI"
cp "$mmx64_efi" "$shim_install_dir/mmx64.efi"

efi_shim_relpath=$(echo "$shim_install_dir/BOOTx64.EFI" | sed -r "s|^$efi_mount||")

efibootmgr --verbose --disk "$shim_drive" --part "$shim_partition" \
    --create --label "$shim_label" --loader "$efi_shim_relpath"


find /boot/ -maxdepth 1 -name 'vmlinuz-*' -exec sh -c "sbsign --key $mok_key --cert $mok_crt --output {} {}" ";"
sbsign --key "$mok_key" --cert "$mok_crt" --output "$grub_efi_file" "$grub_efi_file"


echo "Copying '$mok_cer' to '$shim_install_dir/MOK.cer'."
echo "MokManager will ask you where this certificate is when you first boot up"
echo "with secure boot turned on."
echo "HINT: It should be located at '/EFI/$shim_label/MOK.cer'."
echo "Once MokManager has verified your ceritifcate, "
echo "you can delete that file from your bootloader."
cp "$mok_cer" "$shim_install_dir/MOK.cer"
