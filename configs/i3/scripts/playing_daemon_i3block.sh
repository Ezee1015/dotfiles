#!/bin/bash

source ~/.config/i3/scripts/refresh_blocks.sh

playerctl --follow metadata --format '{{status}} {{playerName}}' | while read -r status; do
   refresh_playing_block
done
