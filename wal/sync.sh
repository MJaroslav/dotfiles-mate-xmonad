#!/bin/bash
source ~/.dotfilesenv

if [ `command -v walogram` ]; then
    walogram &> /tmp/wal.walogram.log & disown
else
    echo "walogram not installed" > /tmp/wal.walogram.log
fi

if [ -f "$WAL_OOMOX_HOME/change_color.sh" ]; then
    $WAL_OOMOX_HOME/change_color.sh -o wal-oomox ~/.cache/wal/colors-oomox &> /tmp/wal.oomox.log & disown
else
    echo "oomox-gtk-theme not installed" > /tmp/wal.oomox.log
fi

if [ -f "$WAL_DISCORD_HOME/wal-discord" ]; then
    $WAL_DISCORD_HOME/wal-discord -t &> /tmp/wal.discord.log & disown
else
    echo "wal-discord not installed" > /tmp/wal.discord.log
fi

if [ -f "$WAL_CHROMIUM_HOME/generate-theme.sh" ]; then 
    $WAL_CHROMIUM_HOME/generate-theme.sh &> /tmp/wal.chromium.log & disown
else
    echo "ChromiumPywal not installed" > /tmp/wal.chromium.log
fi

wal_web() {
    wallpaper_path=`cat ~/.cache/wal/colors.css | grep -o '".*"' | sed 's/"//g'`
    cp $wallpaper_path $WAL_WEB_HOME/wal.background
    cp ~/.cache/wal/colors.css $WAL_WEB_HOME/wal.colors.css
    sed -i "s@$wallpaper_path@http://localhost/wal.background@g" $WAL_WEB_HOME/wal.colors.css
}

if [ -d "$WAL_WEB_HOME" ]; then
    wal_web &> /tmp/wal.web.log & disown
else
    echo "No local web server found" > /tmp/wal.web.log
fi
