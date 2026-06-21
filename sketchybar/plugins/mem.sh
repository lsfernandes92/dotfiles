#!/usr/bin/env bash

FREE_PERCENT="$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}' | tr -d '%')"
USED_PERCENT=$((100 - FREE_PERCENT))

sketchybar -m --set "$NAME" label="${USED_PERCENT}%"
