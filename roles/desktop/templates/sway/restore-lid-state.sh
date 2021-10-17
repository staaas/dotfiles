#!/usr/bin/bash
laptopscreen=${1:-eDP-1}
if grep -q open /proc/acpi/button/lid/LID/state; then
    swaymsg output $laptopscreen enable
else
    swaymsg output $laptopscreen disable
fi
