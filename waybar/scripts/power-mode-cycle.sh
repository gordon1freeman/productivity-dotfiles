#!/bin/bash
mode=$(powerprofilesctl get)
case "$mode" in
    performance) powerprofilesctl set balanced ;;
    balanced) powerprofilesctl set power-saver ;;
    power-saver) powerprofilesctl set performance ;;
esac
pkill -RTMIN+8 waybar
