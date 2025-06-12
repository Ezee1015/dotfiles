#!/bin/bash

(scrot - | convert - -blur 0x4 - | composite -gravity southeast ~/.config/i3/images/i3lock-overlay.png - /tmp/lock.png) && i3lock -i /tmp/lock.png
