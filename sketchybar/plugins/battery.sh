#!/bin/bash

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
TIME_LEFT="$(pmset -g batt | grep -Eo "[0-9]+:[0-9]+ remaining" | cut -d' ' -f1)"

if [ -z "$TIME_LEFT" ]; then
  TIME_LEFT="--:--"
fi

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""
  ;;
  [6-8][0-9]) ICON=""
  ;;
  [3-5][0-9]) ICON=""
  ;;
  [1-2][0-9]) ICON=""
  ;;
  *) ICON=""
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%($TIME_LEFT)"
