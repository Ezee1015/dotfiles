if [ -z $TRESSHOLD ]; then
  TRESSHOLD=$(free | grep Mem | awk '{print $2/2}')
fi
if [ -z $URGENCY ]; then
  URGENCY=$(free | grep Mem | awk '{print $2/4*3}')
fi
if [ -z $TRESS_COLOR ]; then
  TRESS_COLOR="#fabd2f"
fi
if [ -z $URGENT_COLOR ]; then
  URGENT_COLOR="#cc241d"
fi

FREE_HUMAN=$(free -h | grep Mem | awk '{print $3}')
FREE_BYTES=$(free | grep Mem | awk '{print $3}')

HTML_URGENT_COLOR="<span color=\"$URGENT_COLOR\">"
HTML_TRESS_COLOR="<span color=\"$TRESS_COLOR\">"
HTML_COLOR_END='</span>'

if [ $FREE_BYTES -gt $URGENCY ]; then
  echo "$HTML_URGENT_COLOR$LABEL  $FREE_HUMAN$HTML_COLOR_END"
elif [ $FREE_BYTES -gt $TRESSHOLD ]; then
  echo "$HTML_TRESS_COLOR$LABEL  $FREE_HUMAN$HTML_COLOR_END"
else
  echo "$LABEL  $FREE_HUMAN"
fi
