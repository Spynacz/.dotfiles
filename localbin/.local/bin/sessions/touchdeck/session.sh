#!/bin/bash

if [[ -z $(pgrep kitty) ]] then
    kitty --session=~/.local/bin/sessions/touchdeck/kitty &
else
    kitten @ --to unix:@mykitty focus-tab --match="title:touchdeck" ||
    kitten @ --to unix:@mykitty launch --type=tab --cwd=~/Dev/TouchDeck --hold --tab-title=touchdeck --title=vim nvim 
    kitten @ --to unix:@mykitty launch --cwd=current --title=pio --bias=40 --hold --dont-take-focus
    kitten @ --to unix:@mykitty launch --cwd=current --title=serial --location=hsplit --bias=20 --hold --dont-take-focus --next-to="title:pio"
    kitten @ --to unix:@mykitty send-text --match="title:serial" "screen /dev/ttyUSB1 115200"
fi

if [[ -z $(pgrep firefox) ]] then
    firefox &
fi

if [[ -z $(pgrep eezstudio ) ]] then
    bspc rule -a eezstudio -o desktop=3 follow=off 
    eez-studio --no-sandbox &
fi
