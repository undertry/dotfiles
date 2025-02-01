#!/usr/bin/env bash

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar on the primary monitor (HDMI-3)
MONITOR=HDMI-3 polybar logo -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar workspaces -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar target -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar music -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar wlan -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar ip -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar cpu -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar memory -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar volume -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar date -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar systray -c $(dirname $0)/config.ini &
MONITOR=HDMI-3 polybar power -c $(dirname $0)/config.ini &

# Launch polybar on the secondary (vertical) monitor (HDMI-1-2)
MONITOR=HDMI-1-2 polybar v-workspaces -c $(dirname $0)/config.ini &
MONITOR=HDMI-1-2 polybar v-window -c $(dirname $0)/config.ini &
