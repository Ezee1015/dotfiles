#!/bin/bash

source ~/.config/i3/scripts/refresh_blocks.sh
source ~/.config/i3/scripts/volume_notification.sh

MUTED=$(amixer sget Master | grep "\[off\]")
STEP=5

increase() {
    if [[ -z "$MUTED" ]]; then
      amixer -q set Master "$STEP%+"
    else
      amixer -q set Master "$STEP%"
      amixer set Master toggle
    fi
    refresh_volume_block
    volume_notification
}

decrease() {
    if [[ -z "$MUTED" ]]; then
      amixer -q set Master "$STEP%-"
      refresh_volume_block
    else
      amixer -q set Master 0%
      amixer set Master toggle
    fi
    volume_notification
}

mute() {
    amixer set Master toggle
    refresh_volume_block
    volume_notification
}

error() {
    echo "You have to provide: increase, decrease or mute"
    exit 1
}

if [[ $# -ne 1 ]]; then
    error
fi

case "$1" in
    "increase") increase ;;
    "decrease") decrease ;;
    "mute")     mute     ;;
    *)          error    ;;
esac
