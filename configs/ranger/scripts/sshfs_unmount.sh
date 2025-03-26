#!/bin/bash

read -p "--> Mount point: /media/$USER/" MOUNTNAME
MOUNTPOINT="/media/$USER/$MOUNTNAME"
if [[ ! -d $MOUNTPOINT ]]; then
  read -p "[ERROR] Folder doesn't exist. Press a Enter to exit..."
  exit 1
fi

fusermount -u "$MOUNTPOINT"
if [[ $? -ne 0 ]]; then
  echo "[ERROR] Error while unmounting $MOUNTPOINT"

  if [ -z "$(grep " $MOUNTPOINT " /etc/mtab)" ] && [ -z "$(ls "$MOUNTPOINT")" ]; then
    read -rn1 -p  "--> $MOUNTPOINT folder is empty. Do you want to remove the folder? [y/N]: " ANS
    if [ "$ANS" == "y" ] || [ "$ANS" == "Y" ]; then
      echo
      sudo -k rmdir "$MOUNTPOINT"
      exit 0
    fi
    echo "[INFO] The folder will not be deleted"
  fi

  read -p "[INFO] Press a Enter to exit..."
  exit 1
fi

sudo -k rmdir "$MOUNTPOINT"
if [[ $? -ne 0 ]]; then
  read -p "[ERROR] Folder $MOUNTPOINT is not empty"
  exit 1
fi
