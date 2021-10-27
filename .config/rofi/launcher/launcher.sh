#!/bin/bash

config_file="${HOME}/.config/rofi/launcher/config.rasi"

rofi -no-lazy-grab \
    -show drun \
    -modi drun \
    -no-config \
    -theme ${config_file} \
    2> /dev/null
