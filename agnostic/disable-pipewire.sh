source ../utils.sh

if [ $(lxsp_detect_init systemd) == "1" ]; then
    systemctl disable --now --user pipewire.service
    systemctl disable --now --user pipewire-pulse.service
    systemctl disable --now --user wireplumber.service
else
    echo -n "systemd not found"
fi
