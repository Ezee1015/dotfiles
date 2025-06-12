if [ -z "$(ps -axo comm | grep zoomme)" ]; then
  ~/github/zoomme/zoomme $@ ;
else
  killall zoomme ;
fi
