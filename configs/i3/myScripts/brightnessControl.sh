#!/bin/zsh

if [ -z "$OUTPUT" ]; then
  OUTPUT=$(xrandr --current | grep " connected" | awk '{print $1}' | head -1)
fi

if [ -z "$JUMP" ]; then
  JUMP="0.1"
fi

CURRENT_BRIGHTNESS=$(xrandr --prop --verbose | grep -A10 "$OUTPUT" | grep "Brightness" | awk '{print $2}')

if [ "$1" = "-inc" ]; then
  xrandr --output $OUTPUT --brightness $(echo "$CURRENT_BRIGHTNESS $JUMP" | LC_NUMERIC="C" awk '{print $1+$2}')
elif [ "$1" = "-dec" ]; then
  xrandr --output $OUTPUT --brightness $(echo "$CURRENT_BRIGHTNESS $JUMP" | LC_NUMERIC="C" awk '{print $1-$2}')
elif [ "$1" = "-reset" ]; then
  xrandr --output $OUTPUT --brightness 1.0
elif [ "$1" = "-set" ] && [ ! -z "$2" ]; then
  xrandr --output $OUTPUT --brightness $2
else
  echo "HELP MANUAL\n"
  echo "- Variables..."
  echo "OUTPUT=[output] $0 [opts]          Specify the output"
  echo "JUMP=[jump] $0 [opts]              Specify the the increase/decrease value"
  echo "\n- Options..."
  echo "$0 -inc                            Increase brightness"
  echo "$0 -dec                            Decrease brightness"
  echo "$0 -reset                          Reset the brightness to the original value (1.0)"
  echo "$0 -set [value]                    Set the brightness to a given value"
  exit 1
fi


CURRENT_BRIGHTNESS=$(xrandr --prop --verbose | grep -A10 " connected" | grep "Brightness" | awk '{print $2}')
BRIGHTNESS_PERCENTAGE=$(echo "$CURRENT_BRIGHTNESS 100" | LC_NUMERIC="C" awk '{print $1*$2}')
if [ "$(dunstify -a "Script de brillo" -u low -r 9993 -h int:value:"$BRIGHTNESS_PERCENTAGE" -i "redshift-status-day" "Brillo: " -t 2000 -A "default,Reset brightness")" = "default" ]; then
  xrandr --output $OUTPUT --brightness 1.0
fi
