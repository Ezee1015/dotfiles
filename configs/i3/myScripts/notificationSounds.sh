#!/bin/bash

if [[ $(dunstctl is-paused) == "true" ]]; then
  M_FILE=~/.config/i3/sounds/notificacion-off.ogg
else
  M_FILE=~/.config/i3/sounds/notificacion-on.ogg
fi

ffplay "$M_FILE" -autoexit -nodisp -loglevel quiet
