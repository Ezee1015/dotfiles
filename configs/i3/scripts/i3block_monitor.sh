#!/bin/bash

source ~/.config/i3/scripts/refresh_blocks.sh

if [[ ! $(xrandr | grep "DisplayPort-0") ]]; then
  exit
fi

if [[ -z "$(xrandr | grep "DisplayPort-0 connected (")" ]]; then
  DP0_DISABLED=on
else
  DP0_DISABLED=off
fi

if [[ $BLOCK_BUTTON -eq 1 ]]; then
  if [[ $DP0_DISABLED == "on" ]] ; then
    xrandr --output DisplayPort-0 --off --output HDMI-A-0 --mode 1920x1080 --rate 74.97 --pos 0x0
    DP0_DISABLED=off
  else
    xrandr --output DisplayPort-0 --mode 1440x900 --rate 74.98 --pos 0x70 --output HDMI-A-0 --mode 1920x1080 --rate 74.97 --pos 1440x0
    DP0_DISABLED=on
  fi
  ~/.config/i3/scripts/wallpaper.sh
  killall -SIGUSR1 conky
fi

if [[ $DP0_DISABLED == "on" ]] ; then
  echo "<span foreground=\"$COLOR_ON\"> $MONITOR_ON </span>"
else
  echo "<span foreground=\"$COLOR_OFF\"> $MONITOR_OFF </span>"
fi

refresh_monitor_block
