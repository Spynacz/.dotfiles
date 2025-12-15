#!/bin/sh

killall deej
deej -c $HOME/.config/deej/config.yaml & disown
