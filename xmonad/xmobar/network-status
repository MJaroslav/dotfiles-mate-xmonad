#!/bin/bash

if [[ `ip route | head -n 1` =~ "enp3s0" ]]; then
  echo " Ethernet"
  exit 0
fi

essid=`iwconfig wlp2s0 | awk -F '"' '/ESSID/ {print $2}'`
stngth=`iwconfig wlp2s0 | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 1`
maxstrbgth=`iwconfig wlp2s0 | awk -F '=' '/Quality/ {print $2}' | cut -d '/' -f 2 | cut -d ' ' -f 1`
let percent=$stngth*100/$maxstrbgth

echo "  $essid $percent%"

exit 0
