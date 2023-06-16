source ../utils.sh

if [ $(lxsp_detect_init systemd) == "1" ]; then
    systemctl enable --now --user pipewire.service
    systemctl enable --now --user pipewire-pulse.service
    systemctl enable --now --user wireplumber.service
else
    echo -n "systemd not found"
fi
