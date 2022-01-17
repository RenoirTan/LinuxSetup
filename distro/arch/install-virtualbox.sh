source ../../utils.sh

sh "./install-packages.sh" "virtualbox"

usermod -a -G vboxusers "$(whoami)"

