source ../../utils.sh

sh "./install-packages.sh" "qemu"

usermod -a -G kvm $(whoami)
usermod -a -G libvirt $(whoami)

sudo virsh net-autostart default
sudo virsh net-start default

