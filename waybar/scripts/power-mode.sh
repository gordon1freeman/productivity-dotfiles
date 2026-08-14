#!/bin/bash
mode=$(powerprofilesctl get)
case "$mode" in
    performance) echo '{"text":"󰓅","tooltip":"Performance"}';;
    balanced) echo '{"text":"󰾅","tooltip":"Balance"}';;
    power-saver) echo '{"text":"󰾆","tooltip":"Power-save"}';;
    *) echo '{"text":"󰾅","tooltip":"'$mode'"}';;
esac
