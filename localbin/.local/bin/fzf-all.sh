#!/bin/sh

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

selected=$(fd . ~ /games --type f --type d --type l --hidden --exclude "*[Cc]ache*" --exclude ".mozilla" --exclude ".m2" --exclude "Trash" | fzf +m --preview 'bat --color=always {}' --preview-window='~3')

if [ -z "$selected" ]; then
    exit 0
fi

selected_name=$(basename "$selected")

if [ -d "$selected" ]; then
    kitty @ focus-tab --match "title:^$selected_name$" ||
        kitty @ launch --type=tab --hold --cwd="$selected" --title="$selected_name"
elif [ -f "$selected" ]; then
    selected_dir=$(dirname "$selected")
    kitty @ focus-tab --match "title:^$selected_name$" ||
        mime=$(mimeo --mimetype "$selected" | awk 'FNR == 2 {print $1}')
        desktop=$(mimeo --mime2desk "$mime" | awk 'FNR == 2 {print $1}')
        deskpath=$(mimeo --finddesk "$desktop" | head -n 1)
        term=$(grep "Terminal=true" "$deskpath")
        if [ $term ]; then
            kitty @ launch --type=tab --cwd="$selected_dir" --title="$selected_name" mimeo "$selected"
        else
            kitty @ launch --type=background mimeo "$selected" 
        fi
fi
