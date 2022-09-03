source ../utils.sh

CD_MODULES="
	all_video
	boot
	btrfs
	cat
	chain
	configfile
	echo
	efifwsetup
	efinet
	ext2
	fat
	font
	gettext
	gfxmenu
	gfxterm
	gfxterm_background
	gzio
	halt
	help
	hfsplus
	iso9660
	jpeg
	keystatus
	loadenv
	loopback
	linux
	ls
	lsefi
	lsefimmap
	lsefisystab
	lssal
	memdisk
	minicmd
	normal
	ntfs
	part_apple
	part_msdos
	part_gpt
	password_pbkdf2
	png
	probe
	reboot
	regexp
	search
	search_fs_uuid
	search_fs_file
	search_label
	sleep
	smbios
	squash4
	test
	true
	video
	xfs
	zfs
	zfscrypt
	zfsinfo
	"

GRUB_MODULES="$CD_MODULES
	cryptodisk
	gcry_arcfour
	gcry_blowfish
	gcry_camellia
	gcry_cast5
	gcry_crc
	gcry_des
	gcry_dsa
	gcry_idea
	gcry_md4
	gcry_md5
	gcry_rfc2268
	gcry_rijndael
	gcry_rmd160
	gcry_rsa
	gcry_seed
	gcry_serpent
	gcry_sha1
	gcry_sha256
	gcry_sha512
	gcry_tiger
	gcry_twofish
	gcry_whirlpool
	luks
	lvm
	mdraid09
	mdraid1x
	raid5rec
	raid6rec
	"

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

grub_sbat_csv="/usr/share/grub/sbat.csv"
if [ $(lxsp_path_exists "$grub_sbat_csv") == "0" ]; then
    echo "$grub_sbat_csv does not exist. Did the GRUB package get installed correctly?"
    exit 1
fi

if [ "$use_removeable" == "n" ]; then
    grub-install --target=x86_64-efi "--efi-directory=$efi_partition" "--bootloader-id=$bootloader_id" --modules="$GRUB_MODULES" --sbat "$grub_sbat_csv"
elif [ "$use_removeable" == "y" ]; then
    grub-install --target=x86_64-efi "--efi-directory=$efi_partition" --removable --recheck --modules="$GRUB_MODULES" --sbat "$grub_sbat_csv"
else
    echo "Invalid answer for REMOVEABLE!"
    exit 1
fi

echo "Now generating GRUB config file..."
grub-mkconfig -o /boot/grub/grub.cfg
echo "Done!"
