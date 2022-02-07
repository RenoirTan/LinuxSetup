source ../utils.sh


required_exec="s2ram;s2both;s2disk"
for executable in $(lxsp_split_str "$required_exec" ";"); do
    if [ $(lxsp_command_exists "$executable") == "0" ]; then
        echo "Could not find $executable"
        exit 1
    fi
done


if [ $(lxsp_path_exists "/etc/suspend.conf") == "0" ]; then
    echo "/etc/suspend.conf does not exist"
    echo "Check if uswsusp has been installed correctly."
    exit 1
fi


if [[ $(lxsp_detect_init "systemd") == "1" ]]; then
    if [ $(lxsp_path_exists "/usr/bin/run-parts") == "0" ]; then
        echo "Please make sure /usr/bin/run-parts has been installed before continuing."
        exit 1
    fi

	lxspr_replace "/etc/systemd/system/systemd-hibernate.service.d/override.conf"
    lxspr_replace "/etc/systemd/system/systemd-hybrid-sleep.service.d/override.conf"
    lxspr_replace "/etc/systemd/system/systemd-suspend.service.d/override.conf"
else
	echo "Only systemd is currently supported."
    echo "You may have to manually configure your init system to suspend/hibernate using uswsusp."
fi


echo "Configure uswsusp by editing /etc/suspend.conf"
echo "REBUILD YOUR INITRAMFS WHERE APPLICABLE"
