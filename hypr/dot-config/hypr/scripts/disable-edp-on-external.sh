#!/bin/bash
# This script disables the internal display (eDP-1) if any external monitor is attached.
# It uses hyprland-monitor-attached (https://github.com/coffebar/hyprland-monitor-attached)
# Customize the display name/resolution as needed.

MONITOR_NAME="eDP-1"
MONITOR_ONLINE=$(hyprctl monitors | grep -c "$MONITOR_NAME (ID")
EXTERNAL_PRESENT="$HOME/.local/bin/hyprland-monitor-attached"

has_external="$($EXTERNAL_PRESENT)"

if [ "$has_external" = "yes" ]; then
  hyprctl keyword monitor "$MONITOR_NAME,disable"
else
  # You can customize the resolution/position for re-enabling
  hyprctl keyword monitor "$MONITOR_NAME,1920x1080,0x0,1"
fi
