#!/usr/bin/env bash

# Get current upload/download speed for an interface and scaled to B/s, KB/s or MB/s.
# It expects to update two items: "network.up" and "network.down".
GREEN=0xff99e5b5
LIGHT_GREEN=0xff3fff8c

# Auto-detect the interface or set NETWORK_INTERFACE for specific instead
DETECTED_INTERFACE=$(route get default 2>/dev/null | awk '/interface:/{print $2}')
INTERFACE="${NETWORK_INTERFACE:-${DETECTED_INTERFACE:-en0}}"
STATE_FILE="/tmp/sketchybar_network_${INTERFACE}.state"

read -r _ _ _ _ _ _ IBYTES _ _ OBYTES _ < <(netstat -ibn | awk -v i="$INTERFACE" '$1==i{print; exit}')
NOW=$(date +%s)

IBYTES=${IBYTES:-0}
OBYTES=${OBYTES:-0}

if [ -f "$STATE_FILE" ]; then
  read -r PREV_IBYTES PREV_OBYTES PREV_TIME < "$STATE_FILE"
else
  PREV_IBYTES=$IBYTES
  PREV_OBYTES=$OBYTES
  PREV_TIME=$NOW
fi

echo "$IBYTES $OBYTES $NOW" > "$STATE_FILE"

DELTA_TIME=$(( NOW - PREV_TIME ))
[ "$DELTA_TIME" -le 0 ] && DELTA_TIME=1

DOWN_BPS=$(( (IBYTES - PREV_IBYTES) / DELTA_TIME ))
UP_BPS=$(( (OBYTES - PREV_OBYTES) / DELTA_TIME ))

[ "$DOWN_BPS" -lt 0 ] && DOWN_BPS=0
[ "$UP_BPS" -lt 0 ] && UP_BPS=0

# --- Format bytes/sec into "027KB/s" / "003MB/s" / "045B/s" --------------
format_speed() {
  local bps=$1
  if   [ "$bps" -lt 1000 ];    then printf "%03dB/s" "$bps"
  elif [ "$bps" -lt 1000000 ]; then printf "%03dKB/s" "$(( bps / 1000 ))"
  else                               printf "%03dMB/s" "$(( bps / 1000000 ))"
  fi
}

UPLOAD=$(format_speed "$UP_BPS")
DOWNLOAD=$(format_speed "$DOWN_BPS")

UP_COLOR=$GREEN;   [ "$UP_BPS"   -eq 0 ] && UP_COLOR=$GREEN
DOWN_COLOR=$GREEN; [ "$DOWN_BPS" -eq 0 ] && DOWN_COLOR=$GREEN

sketchybar --set network.up   label="$UPLOAD"   icon.color="$UP_COLOR"   label.color="$UP_COLOR" \
           --set network.down label="$DOWNLOAD" icon.color="$DOWN_COLOR" label.color="$DOWN_COLOR"
           