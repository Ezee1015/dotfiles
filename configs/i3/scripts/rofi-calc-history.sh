#!/bin/bash

rofi -show calc -calc-command "bash -c 'EXP=\"{expression}\"; if [[ -z \$EXP ]]; then echo \"{result}\"; else echo \"{expression}\"; fi' | tr -d '\n' | xclip -selection clipboard"
