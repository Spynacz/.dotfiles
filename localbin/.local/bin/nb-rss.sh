#!/bin/bash 
ebook-convert "/home/mateusz/.config/calibre/custom_recipes/Naukowy Belkot_1000.recipe" "naukowy-bełkot.epub"

calibre-smtp -s "Naukowy Bełkot RSS" -a naukowy-bełkot.epub -r smtp.gmail.com --port 587 -u "mrspinacz@gmail.com -p "bolmxyswmqeoohwj" --verbose mrspinacz@gmail.com franekkindle@kindle.com text
