#! /bin/sh

WALLPAPER_DIR="$XDG_PICTURES_DIR/wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" | shuf -n 1)

[ -z "$WALLPAPER" ] && exit 1

awww img --transition-type grow --transition-pos top-right "$WALLPAPER"
