#!/bin/bash

[[ "${2}:${3}" == "spectacle:spectacle" ]] &&
xprop -id "$1" _NET_WM_WINDOW_TYPE | grep -q _KDE_NET_WM_WINDOW_TYPE_OVERRIDE &&
echo "border=off state=floating manage=off"
