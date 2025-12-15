#!/bin/bash

if ! wmctrl -lp | grep -qi 'YouTube Music'; then
    youtube-music &
    while [ -z "$(wmctrl -lp | grep -i 'YouTube Music')" ]; do
        sleep 0.5
    done
fi
xdo activate $(wmctrl -lp | grep -i 'YouTube Music' | awk '{print $1}')
