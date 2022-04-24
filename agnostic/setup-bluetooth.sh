source ../utils.sh

if [ $(lxsp_detect_init systemd) == "1" ]; then
    systemctl enable --now bluetooth
else
    echo -n "systemd not found"
    exit 1
fi

echo "You have to restart your computer for bluetooth to work"
