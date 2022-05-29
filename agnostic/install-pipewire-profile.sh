source ../utils.sh

lxsp_replace .config/easyeffects/input/pipewire.json
echo "At this point, you should open easyeffects, set 'pipewire' as the preset"
echo "for input and dial the microphone volume (not EasyEffects Source) to a "
echo "value of at most 20%. Any higher and the audio quality will deteriorate."
echo "If the volume is too soft:"
echo "    1. Open EasyEffects"
echo "    2. Select the 'Input' tab at the top"
echo "    3. Select 'Effects' at the bottom"
echo "    4. Select 'Noise Reduction' on the left"
echo "    5. Increase the 'Output' slider until the volume is satisfactory"
