#!/bin/bash

REMAP_CONTROL_CAPS_LOCK="ctrl:nocaps"
# REMAP_SUPER_ALT="altwin:swap_lalt_lwin"
# REMAP_SUPER_CAPS_LOCK="caps:super"

CAPS_FUNCTION="$REMAP_CONTROL_CAPS_LOCK" # ,$REMAP_SUPER_ALT,$REMAP_SUPER_CAPS_LOCK

MAPED=$(setxkbmap -query | grep "$CAPS_FUNCTION")
if [[ -z $MAPED ]]; then
  echo "Keys remapped"
  setxkbmap -option "$CAPS_FUNCTION"
else
  echo "Keys mapped normal"
  setxkbmap -option
fi
