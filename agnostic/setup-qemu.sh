source ../utils.sh

usermod -a -G kvm "$(whoami)"
usermod -a -G libvirt "$(whoami)"

if [ $(lxsp_detect_init "systemd") == "1" ]; then
	systemctl enable libvirtd
	systemctl start libvirtd
	virsh net-autostart default
	virsh net-start default
else
	echo "Please start libvirtd. Then run:"
	echo " # virsh net-autostart default"
	echo " # virsh net-start default"
fi
