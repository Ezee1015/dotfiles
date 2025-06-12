#!/bin/bash

refresh_volume_block() {
  pkill -SIGRTMIN+2 i3blocks
}

refresh_caps_lock_block() {
  pkill -SIGRTMIN+10 i3blocks
}

refresh_mute_block() {
  pkill -SIGRTMIN+3 i3blocks
}

refresh_mic_block() {
  pkill -SIGRTMIN+4 i3blocks
}

refresh_monitor_block() {
  pkill -SIGRTMIN+1 i3blocks
}
