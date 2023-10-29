#!/bin/sh
selected=$(fd . ~ --type d -H -E .cache | fzf +m)

if [ -z "$selected" ]; then
    exit 0
fi

selected_name=$(basename "$selected")

kitty @ launch --type=tab --hold --cwd=$selected --tab-title=$selected_name --window-title=$selected_name
