source ../utils.sh

OLD_PWD=$(pwd)

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src # Mostly for bash

echo -n "Do you want to add pyenv to ~/.profile? [y/N] "
read -r reply

if [ "$reply" == "y" || "$reply" == "Y" ]; then
	echo "Adding pyenv to ~/.profile..."
	cat "./pyenv-profile.txt" >> "$HOME/.profile"
	echo "Restart terminal for changes to take effect."
elif [ "$reply" == "n" || "$reply" == "N" ]; then
	echo "Not adding pyenv to ~/.profile."
else
	echo "Invalid reply: $reply."
fi

cd $OLD_PWD

