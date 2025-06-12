#!/bin/bash

source ~/.config/i3/myScripts/refresh_blocks.sh
source ~/.config/i3/sounds/notification.sh

if [[ ! -z $BLOCK_BUTTON ]]; then
  BLOCK_BUTTON=1 ~/.config/i3/i3blocks-plugins/dunst/dunst
  pkill ffplay
  refresh_mute_block
  notification_sound
  exit 0
fi

~/.config/i3/i3blocks-plugins/dunst/dunst
