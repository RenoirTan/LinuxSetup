source ../../utils.sh

# I could have stored the command in a variable and used exec as yay is
# CLI-compatible with pacman.
# However zsh keeps crashing whenever I try to use exec.

command -v pacman > /dev/null && pacman_installed=1
aur_helper=""
command -v yay > /dev/null && aur_helper=yay
command -v paru > /dev/null && aur_helper=paru

if [ "$aur_helper" == "" ]; then
	echo "Warning! A suitable AUR helper has not been installed yet."
	echo "You can install either yay or paru to install packages from the AUR."
	echo "Run 'setup distro/arch/install-yay.sh' to install yay."
fi

if [ "$pacman_installed" != 1 ] && [ "$aur_helper" == "" ]; then
	echo "No supported package managers found."
	echo "Please install one of the available package managers for Arch Linux, especially pacman."
	echo "Supported AUR helpers: yay, paru"
	exit 1
fi

for collection in $@; do
	colfile="./packages/$collection-packages.txt"
	if [ ! -f "$colfile" ]; then
		echo "Skipping $collection because $colfile does not exist."
		continue
	fi
	if [ "$aur_helper" != "" ]; then
		$aur_helper -Syuv - < "$colfile"
	else
		if [ $(echo $collection | grep 'aur' | wc -l) != 0 ]; then
			echo "Skipping $collection because an AUR helper has not been installed."
			continue
		fi
		pacman -Syuv - < "$colfile"
	fi
done

