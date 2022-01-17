source ../utils.sh

usermod -a -G kvm "$(whoami)"
usermod -a -G libvirt "$(whoami)"

if [[ $(lxsp_detect_init "systemd") == "1" ]]; then
	systemctl enable libvirtd
	systemctl start libvirtd
else
	echo "Please start libvirtd."
fi

virsh net-autostart default
virsh net-start default

