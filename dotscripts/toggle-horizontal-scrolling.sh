#!/bin/bash

if [[ $(xinput list-props "SynPS/2 Synaptics TouchPad" | grep "libinput Horizontal Scroll Enabled" | grep -o ".$") -eq 1 ]]; then
    xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Horizontal Scroll Enabled" 0
else
    xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Horizontal Scroll Enabled" 1
fi
