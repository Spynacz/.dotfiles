#!/bin/sh
selected=$(fd . ~ ~/Dev ~/Dev/Java ~/Documents ~/Documents/RPG ~/Documents/RPG/DND \
    ~/Documents/Studia/Semestr* ~/.config/nvim --exact-depth 1 --type d | fzf +m)

if [ -z "$selected" ]; then
    exit 0
fi

selected_name=$(basename "$selected")

kitty @ launch --type=tab --hold --cwd=$selected --title=$selected_name
