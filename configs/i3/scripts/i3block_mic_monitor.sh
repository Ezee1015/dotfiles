#!/bin/bash
MIC_PATH=/proc/asound/card*/pcm*c/sub0/status

if [[ $(grep -HIn "RUNNING" $MIC_PATH) ]]; then
  APP_NAME=$(pacmd list-source-outputs | grep 'application.process.binary' | sort -u | awk '{print $3}' | tr '\n' ',' | sed -e 's/"//g' -e 's/,$//g' -e 's/,/, /g' -e 's/, \([^,]*\)$/ y \1/')
  if [[ "$APP_NAME" ]]; then APP_NAME=" $APP_NAME"; fi
  echo "<span foreground=\"$MIC_ON_FG\" background=\"$MIC_ON_BG\"> $MIC_ICON$APP_NAME </span>"
else
  if [[ -z "$(ls $MIC_PATH)" ]]; then exit 0; fi # No mic available
  if [[ ! -z $MIC_OFF ]] then echo "<span foreground=\"$MIC_OFF\">$MIC_ICON</span>"; fi
fi
