#!/bin/bash

#Sync both directories considering which file was modified last
rclone bisync ~/Documents/Studia/Semestr-3 onedrive:Semestr-3 --exclude=Nagrania/ --exclude=.metadata/  --skip-links -v --log-file=/home/mateusz/rclone-log
