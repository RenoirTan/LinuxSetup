source ../utils.sh

echo -n "Have you added the contents of 'agnostic/rust-profile.txt' to ~/.profile yet? [y/N]"
read -r reply
if [ "$reply" != "y" && "$reply" != "Y" ]; then
	echo "Aborting!"
	exit 0
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

