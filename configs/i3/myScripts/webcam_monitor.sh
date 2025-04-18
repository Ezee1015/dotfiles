#!/bin/bash

WEBCAMS=(/dev/video*)

# No webcams detected
if [[ "$WEBCAMS" == "/dev/video*" ]]; then exit; fi
# WEBCAMS_LEN=${#WEBCAMS[@]}
# if [[ $WEBCAMS_LEN -eq 0 ]]; then exit 0; fi

FIRST="${WEBCAMS[0]}"
for WC in "${WEBCAMS[@]}"; do
  FUSER="$(fuser $WC 2> /dev/null)"
  if [[ $FUSER ]]; then
    APP_ID=$(echo "$FUSER" | awk '{print $1}')
    APP_NAME=$(ps -p $APP_ID | awk '{print $4}' | tail --lines 1)

    if [[ "$WC" != "$FIRST" ]] ; then echo -n "<span foreground=\"$DIVIDER_COLOR\"> | </span>"; fi

    echo -n "<span foreground=\"$WEBCAM_ON\">$WEBCAM_ICON"
    # If there's more than 1 camera, specify its ID from /dev/video[ID]
    if [[ $WEBCAMS_LEN -gt 1 ]]; then
      WC_ID=$(echo $WC | grep -o -E '[0-9]+')
      echo -n "($WC_ID)"
    fi
    ##
    echo -n " $APP_NAME</span>"
  fi
done
echo ""
