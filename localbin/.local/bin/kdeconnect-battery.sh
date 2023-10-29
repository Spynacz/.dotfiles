#!/bin/bash

DEVICE_ID=1d5da35be189b1ef
LOW_BATTERY=30
HIGH_BATTERY=80

is_charging=$(qdbus org.kde.kdeconnect.daemon /modules/kdeconnect/devices/"$DEVICE_ID"/battery org.kde.kdeconnect.device.battery.isCharging)
device_name=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/"$DEVICE_ID" org.kde.kdeconnect.device.name)
battery_percentage=$(qdbus org.kde.kdeconnect.daemon /modules/kdeconnect/devices/"$DEVICE_ID"/battery org.kde.kdeconnect.device.battery.charge)

if [ "$battery_percentage" -lt "$LOW_BATTERY" ] && [ $is_charging = "false" ] && [ "$battery_percentage" -gt 1 ]
then
    notify-send -u normal -t 5000 -c device --app-name="KDE Connect" -i battery "$device_name" "Connect the phone to the charger. Battery level: $battery_percentage %"
elif [ "$battery_percentage" -ge "$HIGH_BATTERY" ] && [ $is_charging = "true" ]
then
    notify-send -u normal -t 5000 -c device --app-name="KDE Connect" -i battery "$device_name" "Unplug the phone. Battery level: $battery_percentage %"
fi
