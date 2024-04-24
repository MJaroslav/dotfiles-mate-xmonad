#!/bin/bash
kill_and_wait() {
    killall -q $1
    while pgrep -x $1 >/dev/null; do sleep 1; done
}

wal -R -o $HOME/.dotfiles/wal/sync.sh -e

kill_and_wait polkit-mate-aut
mate-polkit &

kill_and_wait flameshot
flameshot &

kill_and_wait compton
compton -f &

kill_and_wait xautolock
xautolock -time 15 -locker "mate-screensaver-command -l" -detectsleep &

kill_and_wait mate-screensaver
mate-screensaver &

kill_and_wait play-with-mpv
play-with-mpv &

kill_and_wait nekoray
nekoray &

# killall xkbvncsync
# $HOME/.dotfiles/bin/xkbvncsync $
