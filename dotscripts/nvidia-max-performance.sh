#!/bin/sh

nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1'
#optirun -b none nvidia-settings -c :8 -a '[gpu:0]/GPUPowerMizerMode=1'
