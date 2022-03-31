source ../utils.sh

[[ $(lxsp_detect_init systemd) == "1" ]] && systemctl enable --now gpm \
    || echo -n "systemd not found"

