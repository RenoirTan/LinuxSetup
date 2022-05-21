source ../utils.sh


echo "This script assumes that your computer supports UEFI."
echo "If your computer does not support UEFI, press Ctrl+C to exit."


required_exec="grub-install"
for executable in $(lxsp_split_str "$required_exec" ";"); do
    if [ $(lxsp_command_exists "$executable") == "0" ]; then
        echo "Could not find $executable"
        exit 1
    fi
done


echo -n "Where is the EFI partition mounted? (e.g. /boot): "
read efi_partition
if [ ! -d $efi_partition ]; then
    echo "'$efi_partition' does not exist. PLease create that folder first!"
fi
echo -n "Do you want to use TPM? (y/n): "
read use_tpm
if [ $use_tpm != "y" ] && [ $use_tpm != "n" ]; then
    echo "Invalid answer"
    exit 1
fi
echo -n "Are you installing GRUB on a removeable medium? (y/n): "
read use_removeable
if [ $use_removeable != "y" ] && [ $use_removeable != "n" ]; then
    echo "Invalid answer"
    exit 1
fi
echo -n "What EFI label do you want to use for GRUB? (GRUB): "
read bootloader_id
if [ -z $bootloader_id ]; then
    echo "No EFI label given, defaulting to 'GRUB'"
    bootloader_id="GRUB"
fi


if [ "$use_tpm" == "n" ]; then
    if [ "$use_removeable" == "n" ]; then
        grub-install --target=x86_64-efi "--efi-directory=$efi_partition" "--bootloader-id=$bootloader_id"
    elif [ "$use_removeable" == "y" ]; then
        grub-install --target=x86_64-efi "--efi-directory=$efi_partition" --removable --recheck
    else
        echo "Invalid answer for REMOVEABLE!"
        exit 1
    fi
elif [ "$use_tpm" == "y" ]; then
    grub_sbat_csv="/usr/share/grub/sbat.csv"
    if [ $(lxsp_path_exists "$grub_sbat_csv") == "0" ]; then
        echo "$grub_sbat_csv does not exist. Did the GRUB package get installed correctly?"
        exit 1
    fi

    if [ "$use_removeable" == "n" ]; then
        grub-install --target=x86_64-efi "--efi-directory=$efi_partition" "--bootloader-id=$bootloader_id" --modules="tpm" --sbat "$grub_sbat_csv"
    elif [ "$use_removeable" == "y" ]; then
        grub-install --target=x86_64-efi "--efi-directory=$efi_partition" --removable --recheck --modules="tpm" --sbat "$grub_sbat_csv"
    else
        echo "Invalid answer for REMOVEABLE!"
        exit 1
    fi
else
    echo "Invalid answer for TPM!"
    exit 1
fi

echo "Now generating GRUB config file..."
grub-mkconfig -o /boot/grub/grub.cfg
echo "Done!"
