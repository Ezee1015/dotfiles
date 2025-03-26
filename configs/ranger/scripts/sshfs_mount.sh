#!/bin/bash

read -p "--> SSH User: " SSH_USER

read -p "--> SSH Host: " SSH_HOST
if [[ -z "$SSH_HOST" ]]; then
  read -p "[ERROR] SSH Host is empty. Press a Enter to exit..."
  exit 1
fi

read -p  "--> SSH Directory: ~/" SSH_DIRECTORY

read -p "--> Mount point: /media/$USER/" MOUNTNAME
MOUNTPOINT="/media/$USER/$MOUNTNAME"
if [[ "$MOUNTPOINT" == "/media/$USER/" ]]; then
  read -p "[ERROR] Unable to mount to $MOUNTPOINT. Press a Enter to exit..."
  exit 1
fi

# Create folder
sudo -k bash -c "mkdir \"$MOUNTPOINT\" && chown $USER:$USER \"$MOUNTPOINT\""
if [[ $? -ne 0 ]]; then
  read -p "[ERROR] Error while creating folder. Press a Enter to exit..."
  exit 1
fi

# Sshfs
if [[ -z "$SSH_USER" ]]; then
  SSH_SOURCE="$SSH_HOST:$SSH_DIRECTORY"
else
  SSH_SOURCE="$SSH_USER@$SSH_HOST:$SSH_DIRECTORY"
fi
sshfs "$SSH_SOURCE" "$MOUNTPOINT"
if [[ $? -ne 0 ]]; then
  read -p "[ERROR] Error while connecting with sshfs"
  exit 1
fi
