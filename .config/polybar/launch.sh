#!/bin/bash

error() { echo -e "$1" && exit; }

[ $EUID -eq 0 ] && error "Do not run this script as root."

DIR="${HOME}/.config/polybar"

killall -q polybar
killall -q volume

while pgrep -u ${UID} -x polybar && pgrep -u $UID -x volume > /dev/null;
do
    sleep 1
done

${DIR}/scripts/volume --headphone &
polybar -r main -c ${DIR}/config.ini &

exit 0
