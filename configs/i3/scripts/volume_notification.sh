#!/bin/sh

volume_notification() {
  MIXER=$(amixer sget Master)
  MUTED=$(echo "$MIXER" | grep "\[off\]")

  if [[ ! -z "$MUTED" ]]; then
    dunstify -a "Volume" -u low -r 9993 -i "audio-off" "Volume Muted" -t 2000
    return
  fi

  VOLUME=$(echo "$MIXER" | awk -F"[][]" '/(Left|Mono):/ { print $2 }' | xargs)
  if [[ "$VOLUME" == "0%" ]]; then
    dunstify -a "Volume" -u low -r 9993 -h int:value:0 -i "audio-off" "Volume: " -t 2000
  else
    dunstify -a "Volume" -u low -r 9993 -h int:value:"$VOLUME" -i "audio-on" "Volume: " -t 2000
  fi
}
