#!/bin/bash

source ~/.config/i3/scripts/refresh_blocks.sh
source ~/.config/i3/scripts/volume_notification.sh

error() {
  echo "You have to provide: increase or decrease"
  exit 1
}

if [[ $# -ne 1 ]]; then
  error
fi

MUTED=$(amixer sget Master | grep "\[off\]")

case "$1" in
  "increase")
    if [[ -z "$MUTED" ]]; then
      amixer -q set Master 5%+
      refresh_volume_block
    fi
    volume_notification
    ;;

  "decrease")
    if [[ -z "$MUTED" ]]; then
      amixer -q set Master 5%-
      refresh_volume_block
    fi
    volume_notification
    ;;

  "mute")
    amixer set Master toggle
    refresh_volume_block
    volume_notification
    ;;

  *)
    error
    ;;
esac
