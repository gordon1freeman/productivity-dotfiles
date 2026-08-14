#!/bin/bash

sel=$(hyprctl clients -j 2>/dev/null | jq -r '.[]
	| select(.mapped == true and .workspace.id != -99)
	| [.workspace.name, .class, .title, .address] | @tsv' \
	| wofi --dmenu --prompt "Window" | cut -f4)

if [ -n "$sel" ]; then
	hyprctl dispatch focuswindow "address:$sel" >/dev/null
fi
