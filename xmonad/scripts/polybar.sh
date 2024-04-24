#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -c ~/.config/polybar/config main 2>&1 | tee -a /tmp/polybar.log & disown

