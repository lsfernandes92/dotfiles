#!/bin/sh

CURRENT_TIME=$(date '+%H:%M')
DATE_PART=$(date '+%a %d %b(%m) %y,')

if [ "$CURRENT_TIME" = "13:12" ]; then
  TIME_DISPLAY="󰲠 󰲤 󰲠 󰲢"
else
  TIME_DISPLAY="$CURRENT_TIME"
fi

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting
sketchybar --set "$NAME" label="$DATE_PART $TIME_DISPLAY"
