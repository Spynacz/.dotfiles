#!/bin/bash

external_display=$(xrandr --query | grep 'HDMI-A-0' | grep -w 'connected')

if [[ "$external_display" = *"connected"* ]]; then
    xrandr --output eDP --mode 2160x1440 --rotate normal
    xrandr --output HDMI-A-0 --primary --mode 2560x1440 --above eDP --rotate normal
    bspc monitor eDP -d 6 7 8 9 10
    bspc monitor HDMI-A-0 -d 1 2 3 4 5
else
    xrandr --output eDP1 --primary --mode 2160x1440 --rotate normal 
    xrandr --output HDMI-A-0 --off
    bspc monitor HDMI-A-0 -r
    bspc monitor eDP -d 1 2 3 4 5 6 7 8 9 10
fi
