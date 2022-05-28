source ../utils.sh

lxsp_replace .config/easyeffects/input/pipewire.json
echo "At this point, you should open easyeffects, set 'pipewire' as the preset"
echo "for input and turn your input microphone volume (not EasyEffects Source)"
echo "to 50%. From 60% onwards, audio quality will begin to deteriorate."
