#! /usr/bin/env bash

# Usage: screenshot.sh <mode> [--save]
#   mode: region | active | output | window
#   --save: save to disk instead of clipboard only

MODE="$1"
SAVE="$2"

# hyprshot requires "-m window -m active" to capture the active window
# hyprshot requires "-m output -m <name>" to capture a specific monitor
if [[ "$MODE" == "active" ]]; then
    MODE_ARGS="--mode window --mode active"
elif [[ "$MODE" == "output" ]]; then
    MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
    MODE_ARGS="--mode output --mode $MONITOR"
else
    MODE_ARGS="--mode $MODE"
fi

ARGS="$MODE_ARGS --freeze --output-folder $XDG_PICTURES_DIR/screenshots"

if [[ "$SAVE" == "--save" ]]; then
    hyprshot $ARGS
else
    hyprshot $ARGS --clipboard-only
fi
