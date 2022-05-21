source ../utils.sh

if [ $(lxsp_detect_init systemd) == "1" ]; then
    systemctl enable --now gpm
else
    echo -n "systemd not found"
fi

