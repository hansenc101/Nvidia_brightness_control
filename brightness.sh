#!/bin/bash
path=/sys/class/backlight/nvidia_wmi_ec_backlight
inotifywait -q -m -e close_write $path |
while read -r event; do        
    actual_brightness=$(cat $path/brightness)        
    scaled_brightness=$(echo "scale=0; (($actual_brightness - 5) * 99) / (255 - 5) + 1" | bc)        
    echo "Actual brightness: $actual_brightness, scaled brightness: $scaled_brightness"        
    #echo $scaled_brightness > /sys/class/backlight/nvidia_0/brightness || echo "Failed to write brightness: $?"
    xrandr --output DP-4 --set Backlight $scaled_brightness
done
