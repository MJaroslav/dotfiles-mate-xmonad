#!/bin/bash
killall polkit-mate-aut
mate-polkit &
killall nitrogen
nitrogen --restore &
killall flameshot
flameshot &
killall compton
compton -f &
killall xautolock
xautolock -time 15 -locker "mate-screensaver-command -l" -delectsleep &
killall mate-screensaver
mate-screensaver &
killall play-with-mpv
play-with-mpv &
killall nekoray
nekoray
