source ../utils.sh

lxspr_backup "/etc/pulse/default.pa"
cat "./pulseaudio-microphone-crackling-defaultpa.txt" | tee "/etc/pulse/default.pa"

