#!/usr/bin/env bash
set -euo pipefail

if pkill -x rofi 2>/dev/null; then
    exit 0
fi

HOTKEYS_FILE="$HOME/.config/niri/hotkeys.txt"
if [ ! -f "$HOTKEYS_FILE" ]; then
    notify-send "Hotkeys" "File not found: $HOTKEYS_FILE" 2>/dev/null || true
    exit 1
fi

format_hotkeys() {
    local cat="General"
    while IFS= read -r line || [ -n "$line" ]; do
        line="$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        [ -z "$line" ] && continue
        [[ "$line" =~ ^# ]] && continue

        if [[ "$line" =~ ^\[(.*)\]$ ]]; then
            cat="${BASH_REMATCH[1]}"
            continue
        fi

        if [[ "$line" == *"|"* ]]; then
            key="$(echo "${line%%|*}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
            desc="$(echo "${line#*|}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
            printf "<span weight='bold' foreground='#f2f2f3'>%-20s</span> <span foreground='#6a666d'>│</span> <span foreground='#bfbac5'>%-28s</span> <span size='small' foreground='#a69eae'>[%s]</span>\n" \
                "$key" "$desc" "$cat"
        fi
    done < "$HOTKEYS_FILE"
}

format_hotkeys | rofi -dmenu \
    -i \
    -markup-rows \
    -p "󰌌 Hotkeys" \
    -theme-str '
        window { width: 780px; }
        listview { lines: 14; }
        inputbar { children: [prompt, entry]; }
        prompt { enabled: true; text-color: @accent; margin: 0px 8px 0px 0px; }
    ' \
    -theme "$HOME/.config/rofi/theme.rasi" >/dev/null 2>&1 || true
