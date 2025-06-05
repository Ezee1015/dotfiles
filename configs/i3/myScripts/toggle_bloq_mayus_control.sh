#!/bin/bash

ENABLED_NOCAPS=$(setxkbmap -query | grep 'ctrl:nocaps')

if [[ -z "$ENABLED_NOCAPS" ]]; then
  echo "Caps lock as Control: on"
  setxkbmap -option ctrl:nocaps
else
  echo "Caps lock as Control: off"
  setxkbmap -option
fi
