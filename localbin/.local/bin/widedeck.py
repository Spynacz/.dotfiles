#!/usr/bin/python

import os
from evdev import InputDevice, categorize, ecodes

dev = InputDevice("/dev/input/by-id/usb-Spynacz_wideboi_vial:f64c2b3c-event-kbd")
dev.grab()


def interpret_key(keycode):
    if keycode == "KEY_F13":
        os.system("xdotool key F13")
    elif keycode == "KEY_F14":
        os.system("xdotool key F14")
    elif keycode == "KEY_F15":
        os.system("xdotool key F15")
    elif keycode == "KEY_F16":
        os.system("xdotool key F16")
    elif keycode == "KEY_F17":
        os.system("xdotool key F17")
    elif keycode == "KEY_F18":
        os.system("xdotool key F18")
    elif keycode == "KEY_F19":
        pass
    elif keycode == "KEY_F20":
        pass
    elif keycode == "KEY_F21":
        pass
    elif keycode == "KEY_F22":
        pass
    elif keycode == "KEY_F23":
        os.system('/home/mateusz/.local/bin/sessions/touchdeck/session.sh')
    elif keycode == "KEY_F24":
        os.system('heroic & disown')
    elif keycode == "KEY_KP1":
        os.system('steam & disown')
    elif keycode == "KEY_KP2":
        os.system('discord & disown')
    elif keycode == "KEY_KP3":
        os.system('easyeffects & disown')
    elif keycode == "KEY_KP4":
        os.system('GTK_THEME=Adwaita:dark pavucontrol & disown')
    elif keycode == "KEY_KP5":
        os.system("xdotool key KP_Begin")


for event in dev.read_loop():
    if event.type == ecodes.EV_KEY:
        key = categorize(event)
        if key.keystate == key.key_down:
            os.system(f'echo {key.keycode}')
            interpret_key(key.keycode)
