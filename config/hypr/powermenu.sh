#!/usr/bin/env bash

if killall rofi; then
    exit 0
fi

# Передаём только чистый текст без лишнего мусора
chosen=$(echo -e "Suspend\nReboot\nShutdown" | rofi -dmenu -theme power -no-custom -disable-history)

case "$chosen" in
    "Suspend")
        systemctl suspend
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
esac
