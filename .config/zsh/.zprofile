#!/bin/zsh

# zsh profile file. This file will be loaded when you're in a tty or open a terminal emulator.

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof Xorg >/dev/null 2>&1  && exec startx "$XDG_CONFIG_HOME/X11/xinitrc"
