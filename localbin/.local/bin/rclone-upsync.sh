#!/bin/bash

#exit if already running
if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi

#Make both directories identical modifying destination
rclone copy ~/Documents/Studia mtfranczyk:Studia --skip-links -P -vv
#rclone sync ~/dev/studia/MP onedrive:dev/MP --skip-links -P
#rclone sync ~/Documents/Studia/Semestr-2/Metody-programowania onedrive:Metody-programowania --skip-links -P
#rclone sync ~/Documents/Studia/Semestr-2/Metody-obliczeniowe onedrive:Metody-obliczeniowe --exclude Nagrania/ --skip-links -P
#rclone sync ~/Documents/Studia/Semestr-2/PEiTC onedrive:PEiTC --exclude Nagrania/ --skip-links -P

#Send notification
#notify-send -a "Rclone synchronization" Synchronized
