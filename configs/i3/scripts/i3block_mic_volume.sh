#!/bin/bash

source ~/.config/i3/scripts/refresh_blocks.sh

STEP=5

toggle_mute () {
  if [[ "$STATUS" == "on" ]]; then
    ffplay ~/.config/i3/sounds/mic_off.mp3 -autoexit -nodisp -loglevel quiet &
  else
    ffplay ~/.config/i3/sounds/mic_on.mp3 -autoexit -nodisp -loglevel quiet > /dev/null
  fi

  STATUS="$(amixer set Capture toggle | awk -F"[][]" '/(Left|Mono):/ { print $4 }')"
}

###########

STATUS="$(amixer get Capture | awk -F"[][]" '/(Left|Mono):/ { print $4 }')"

case $BLOCK_BUTTON in
  1|2|3) # left/middle/right click, mute/unmute
    toggle_mute
    ;;

  4) # scroll up, increase
    if [[ "$STATUS" == "off" ]]; then
      toggle_mute
    fi

    amixer -q sset Capture ${STEP}%+
    ;;

  5) # scroll down, decrease
    if [[ "$STATUS" == "off" ]]; then
      toggle_mute
    fi

    amixer -q sset Capture ${STEP}%-
    ;;

esac

# Print status
if [[ "$STATUS" == "on" ]]; then
  echo "<span foreground=\"$COLOR_ON\"> $MIC_ON $(amixer get Capture | awk -F"[][]" '/(Left|Mono):/ { print $2 }') </span>"
else
  echo "<span foreground=\"$COLOR_OFF\"> $MIC_OFF </span>"
fi

refresh_mic_block
