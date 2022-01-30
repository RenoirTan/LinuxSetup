source ../utils.sh

lxspr_backup "/etc/pulse/default.pa"
sed 's/^\s*load-module module-udev-detect\s*$/load-module module-udev-detect tsched=0/g'
cat "./pulseaudio-microphone-crackling-defaultpa.txt" | tee "/etc/pulse/default.pa"

