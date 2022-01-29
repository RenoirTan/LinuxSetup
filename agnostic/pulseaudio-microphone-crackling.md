**This serves as a guide to get alleviate the microphone crackling issues when
using pulseaudio rather than to get rid of it completely as the crackling
problems still exist, just that they are quiet enough to be considered
harmless static.**


## Step 1

Run

```shell
$ pacmd list-sources
```

to get a list of input sources (e.g. mics)

## Step 2

Copy the name of the relevant input source.

For example, mine was `alsa_input.pci-0000_00_1f.3.analog-stereo`

## Step 3

Open `/etc/pulse/default.pa` in a text editor.

## Step 4

Add

```
load-module module-remap-source master=<NAME OF SOURCE>
```

to the end of that file.

For example, with my current system:

```
load-module module-remap-source master=alsa_input.pci-0000_00_1f.3.analog-stereo
```

## Step 5

Using any audio mixer, reduce the microphone boost to a value as low as
possible (without compromising on audibility).

Reduce the microphone volume to 50%.

Increase the remapped microphone volume to 150%.

These settings should hopefully get rid of the issues with microphone
crackling coming from microphone boosting without sacrificing volume.

