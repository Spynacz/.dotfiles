#!/bin/bash

upSeconds = "$(cat /proc/uptime | grep -o '^[0-9]\+')"
upMinutes = $((${upSeconds} / 60))

if [[ "${upMinutes}" -le "$(date +"%M")" ]]; then
	#/usr/local/bin/rclone-upsync.sh
	echo 'Syncing at shutdown';
fi
