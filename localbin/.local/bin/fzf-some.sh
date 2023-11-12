#!/bin/sh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

selected=$(fd . ~ ~/Dev ~/Dev/Java ~/Documents ~/Documents/RPG ~/Documents/RPG/DND \
    ~/Documents/Studia/Semestr* --exact-depth 1 --type d | fzf +m)

if [ -z "$selected" ]; then
    exit 0
fi

selected_name=$(basename "$selected")

kitty @ focus-tab --match "title:^$selected_name$" ||
    kitty @ launch --type=tab --hold --cwd=$selected --title=$selected_name --tab-title=$selected_name
