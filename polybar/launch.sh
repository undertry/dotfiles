#!/usr/bin/env bash

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar logo -c $(dirname $0)/config.ini &
polybar workspaces -c $(dirname $0)/config.ini &
polybar window -c $(dirname $0)/config.ini &
polybar target -c $(dirname $0)/config.ini &
polybar music -c $(dirname $0)/config.ini &
polybar wlan -c $(dirname $0)/config.ini &
polybar ip -c $(dirname $0)/config.ini &
polybar cpu -c $(dirname $0)/config.ini &
polybar memory -c $(dirname $0)/config.ini &
polybar volume -c $(dirname $0)/config.ini &
polybar date -c $(dirname $0)/config.ini &
polybar systray -c $(dirname $0)/config.ini &
polybar power -c $(dirname $0)/config.ini &

if [[ $(xrandr -q | grep 'HDMI1 connected') ]]; then
	polybar external -c $(dirname $0)/config.ini &
fi
