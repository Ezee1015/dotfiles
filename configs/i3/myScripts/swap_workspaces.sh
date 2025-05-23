#!/usr/bin/env bash

# Source: https://i3wm.org/docs/user-contributed/swapping-workspaces.html
# requires jq

DISPLAY_CONFIG=($(i3-msg -t get_outputs | jq -r '.[]|"\(.name):\(.current_workspace)"'))

for ROW in "${DISPLAY_CONFIG[@]}"
do
  IFS=':'
  read -ra CONFIG <<< "${ROW}"
  if [ "${CONFIG[0]}" != "null" ] && [ "${CONFIG[1]}" != "null" ]; then
    echo "moving ${CONFIG[1]} right..."
    i3-msg -- workspace --no-auto-back-and-forth "${CONFIG[1]}"
    i3-msg -- move workspace to output right
  fi
done
