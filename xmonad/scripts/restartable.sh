#!/bin/bash
killall polkit-mate-aut
while pgrep -x polkit-mate-aut >/dev/null; do sleep 1; done
mate-polkit &

# killall nitrogen
# while pgrep -x polybar >/dev/null; do sleep 1; done
nitrogen --restore &

killall flameshot
while pgrep -x flameshot >/dev/null; do sleep 1; done
flameshot &

killall compton
while pgrep -x compton >/dev/null; do sleep 1; done
compton -f &

killall xautolock
while pgrep -x xautolock >/dev/null; do sleep 1; done
xautolock -time 15 -locker "mate-screensaver-command -l" -detectsleep &

killall mate-screensaver
while pgrep -x mate-screensaver >/dev/null; do sleep 1; done
mate-screensaver &

killall play-with-mpv
while pgrep -x play-with-mpv >/dev/null; do sleep 1; done
play-with-mpv &

killall nekoray
while pgrep -x nekoray >/dev/null; do sleep 1; done
nekoray &

killall xkbvncsync
$HOME/.dotfiles/bin/xkbvncsync $
