#!/bin/sh

volume=$(amixer sget Master | awk -F"[][]" '/(Left|Mono):/ { print $2 }')
dunstify -a "Volume" -u low -r 9993 -h int:value:"$volume" -i "audio-on" "Volume: " -t 2000
