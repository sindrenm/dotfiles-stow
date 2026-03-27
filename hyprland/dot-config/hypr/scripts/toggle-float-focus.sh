#! /bin/sh

active_is_floating() {
  floating=$(hyprctl activewindow -j | jq -r '.floating')

  [ "$floating" = "true" ]
}

if command -v jq > /dev/null && active_is_floating; then
  hyprctl dispatch focuswindow tiled
else
  hyprctl dispatch focuswindow floating
fi
