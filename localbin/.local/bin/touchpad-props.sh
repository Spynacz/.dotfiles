#!/bin/bash

if [ "$1" = "" ]; then 
    echo "dsaf"
    exit 1
fi

ids=$(xinput --list | awk -v search="$1" \
    '$0 ~ search {match($0, /id=[0-9]+/);\
                  if (RSTART) \
                    print substr($0, RSTART+3, RLENGTH-3)\
                 }'\
     )

for i in $ids
do
    xinput set-prop "$i" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$i" "libinput Tapping Drag Lock Enabled" 1
done
