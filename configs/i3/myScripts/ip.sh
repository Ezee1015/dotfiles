#!/bin/bash

# Get the IP and Device used
INFO=$(ip route get 1)
# Close if there's no connection
if [[ -z "$INFO" ]]; then exit 0; fi
DEVICE=$(echo "$INFO" | awk '{print $(NF-4);exit}')
IP=$(echo "$INFO" | awk '{print $(NF-2);exit}')

# Get more information about the device
INFO=$(nmcli connection show --active | grep "$DEVICE")
TYPE=$(echo "$INFO" | awk '{print $(NF-1);exit}')
NAME=$(echo "$INFO" | awk '{ for (i=1;i<NF-2;i++) { print $i } }' | tr '\n' ' ')
NAME=${NAME::-1} # Remove trailing space at the end

# Hide sensitive information
if [[ "$(dunstctl is-paused)" == "true" ]]; then
  IP=$(echo "$IP" | sed 's/[0-9]/*/g');
  NAME=$DEVICE
fi

if [[ "$TYPE" == "ethernet" ]]; then
  echo "  (Wired) $IP"
else
  echo "  ($NAME) $IP"
fi
