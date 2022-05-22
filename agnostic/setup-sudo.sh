source ../utils.sh

if [ $(lxsp_command_exists python3) == "0" ]; then
    echo "python3 is needed because sed doesn't allow negative lookaheads."
    exit 1
fi

if [ ! -f /etc/group ]; then
    echo "Could not find '/etc/group'. Aborting!"
    exit 1
fi
sudo_group=$(cat /etc/group | awk -F ':' '{print $1}' | grep -E '(sudo|wheel)')
candidates_count=$(echo $sudo_group | wc -l)
if [ "$candidates_count" == 1 ]; then
    lxspr_backup /etc/sudoers
    python3 ./edit-sudoers.py "$sudo_group"
    cp /tmp/sudoers /etc/sudoers
elif [ "$candidates_count" == 0 ]; then
    echo "'sudo' or 'wheel' group not found."
    echo "Please make sure sudo was installed properly on your system."
else
    echo -n "More than one candidate group found: "
    for candidate in $sudo_group; do
        echo -n "$candidate"
    done
    echo "Aborting!"
    exit 1
fi
