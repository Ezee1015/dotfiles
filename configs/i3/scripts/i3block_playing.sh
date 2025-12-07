#!/bin/bash

# Mouse actions
case $BLOCK_BUTTON in
  1) # left click
    ~/.config/i3/scripts/playing_control.sh play-pause
    ;;
  2) # wheel click
    ~/.config/i3/scripts/playing_control.sh stop
    ;;
  3) # right click
    ~/.config/i3/scripts/playing_control.sh next-player
    ;;
  4) # scroll up
    ~/.config/i3/scripts/playing_control.sh next-song
    ;;
  5) # scroll down
    ~/.config/i3/scripts/playing_control.sh previous-song
    ;;
esac

if type -p "dunstctl" > /dev/null && [[ "$(dunstctl is-paused)" == "true" ]]; then
  exit 0
fi


PLAYERS=$(playerctl -l | wc -l)
if [[ $PLAYERS -eq 0 ]]; then exit; fi

if [[ -z $MAX_CHARS ]]; then
  MAX_CHARS=63
fi

CUR_TITLE=$(playerctl metadata title)
CUR_STATUS=$(playerctl status)

##### Code

# Indicate if there's more than one file playing
if [[ $PLAYERS -gt 1 ]]; then
  echo -n "[$PLAYERS] "
fi

# Cut the title if it's too long
if [ ${#CUR_TITLE} -gt $MAX_CHARS ]; then
  CUR_TITLE="${CUR_TITLE:0:$(expr $MAX_CHARS - 3)}..."
fi

# Icon
case $CUR_STATUS in
  "Playing") CUR_STATUS_ICON="♪" ;;
  "Paused")  CUR_STATUS_ICON="󰐎" ;;
  *)         CUR_STATUS_ICON="?" ;;
esac

# Print it
echo "$CUR_STATUS_ICON $CUR_TITLE"
