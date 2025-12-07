#!/bin/bash

source ~/.config/i3/scripts/refresh_blocks.sh

action_play_pause() {
    playerctl play-pause
    refresh_playing_block
}

action_stop() {
    playerctl stop
    refresh_playing_block
}

action_next_player() {
    playerctld shift
    refresh_playing_block
}

action_next_song() {
    playerctl next
    refresh_playing_block
}

action_previous_song() {
    playerctl previous
    refresh_playing_block
}

if [[ ! -z "$1" ]]; then
    case $1 in
        "play-pause") action_play_pause ;;
        "stop") action_stop ;;
        "next-player") action_next_player ;;
        "next-song") action_next_song ;;
        "previous-song") action_previous_song ;;
        *) echo "not implemented '$1'"; exit 1 ;;
    esac
fi
