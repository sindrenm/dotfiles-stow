#! /bin/sh

is_on_special() {
  workspace=$(hyprctl activewindow -j | jq -r '.workspace.name')

  [ "${workspace#special:}" != "$workspace" ]
}

if command -v jq > /dev/null && is_on_special; then
  hyprctl dispatch movetoworkspace e+0
else
  hyprctl dispatch movetoworkspace special
fi
