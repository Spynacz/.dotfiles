#!/bin/bash

if ! wmctrl -lp | grep -q Discord | grep -v Mozilla; then
    discord &
    while [ -z "$(wmctrl -lp | grep Discord)" ]; do
        sleep 0.5
    done
fi
xdo activate $(wmctrl -lp | grep Discord | grep -v Mozilla | awk '{print $1}')
