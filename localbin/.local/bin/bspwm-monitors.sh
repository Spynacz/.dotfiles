#!/bin/sh

hdmi=$(xrandr --query | grep 'HDMI-0' | awk '{print $2}')
dp=$(xrandr --query | grep 'DP-0' | awk '{print $2}')

if [ $hdmi = connected ]; then
    xrandr --output HDMI-0 --primary --mode 2560x1440 --rate 144 --pos 1080x180
    bspc monitor HDMI-0 -d 1 2 3 4 5
fi

if [ $dp = connected ]; then
    xrandr --output DP-0 --mode 1920x1080 --rate 144 --pos 0x0 --rotate left
    bspc monitor DP-0 -d 6 7 8 9 10
fi

bspc wm -O HDMI-0 DP-0
