#!/bin/bash
set -euo pipefail

class="$1"
shift
cmd="$*"

if hyprctl clients -j | jq -e --arg c "$class" 'any(.[]; .class == $c)' >/dev/null 2>&1; then
    hyprctl dispatch "hl.dsp.window.close({ window = \"class:$class\" })" >/dev/null
    sleep 0.5
    if hyprctl clients -j | jq -e --arg c "$class" 'any(.[]; .class == $c)' >/dev/null 2>&1; then
        hyprctl dispatch "hl.dsp.window.kill({ window = \"class:$class\" })" >/dev/null
    fi
else
    eval "$cmd" >/dev/null 2>&1 &
fi
