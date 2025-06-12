#!/bin/bash

source ~/.config/i3/myScripts/refresh_blocks.sh
source ~/.config/i3/myScripts/volNotify.sh

error() {
  echo "You have to provide: increase or decrease"
  exit 1
}

if [[ $# -ne 1 ]]; then
  error
fi

case "$1" in
  "increase")
    amixer -q set Master 5%+
    refresh_volume_block
    volume_notification
    ;;

  "decrease")
    amixer -q set Master 5%-
    refresh_volume_block
    volume_notification
    ;;

  *)
    error
    ;;
esac
