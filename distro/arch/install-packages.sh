source ../../utils.sh

# I could have stored the command in a variable and used exec as yay is
# CLI-compatible with pacman.
# However zsh keeps crashing whenever I try to use exec.

command -v pacman > /dev/null && pacman_installed=1
command -v yay > /dev/null && yay_installed=1

if [ "$yay_installed" != 1 ]; then
	echo "Warning! Yay has not been installed yet."
	echo "Run 'setup distro/arch/install-yay.sh' to install yay."
fi

if [ "$pacman_installed" != 1 && "$yay_installed" != 1 ]; then
	echo "No supported package managers found."
	echo "Please install either pacman or yay."
fi

for collection in $@; do
	colfile="./$collection-packages.txt"
	if [ ! -f "$colfile" ]; then
		echo "Skipping $collection because $colfile does not exist."
		continue
	fi
	if [ "$yay_installed" == 1 ]; then
		yay -Syuv - < "$colfile"
	else
		if [ "$collection" == "yay" ]; then
			echo "Skipping $collection because yay has not been installed."
			continue
		fi
		sudo pacman -Syuv - < "$colfile"
	fi
done

