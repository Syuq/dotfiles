#!/bin/bash

error() { echo -e "$1" && exit; }

[ $EUID -eq 0 ] && error "Do not run this script as root."

DIR="$HOME/.config/polybar"

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

polybar -r main -c "$DIR"/config.ini &

exit 0
