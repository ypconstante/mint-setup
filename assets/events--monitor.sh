#!/bin/bash

disable_bluetooth() {
    pkill blueman-applet
    pkill blueman-manager
    rfkill block bluetooth
}

close_jetbrains_toolbox() {
    pkill jetbrains-toolb
}

mute() {
    amixer -q -D pulse sset Master mute
    mute_speakers
}

mute_speakers() {
    grep -v '^\s\s' /proc/asound/cards | cut -d ' ' -f 2 |
        while read card; do
            amixer -Dhw:"$card" -q set Speaker mute &> /dev/null
            amixer -Dhw:"$card" -q set Speaker 0% &> /dev/null
        done
}

pause() {
    # https://github.com/folixg/pause-on-lock/blob/master/pause-on-lock
    PAUSED_PLAYER="none"

    read -r -a players <<< "$(playerctl --list-all)"
    for player in "${players[@]}"; do
      if [ "$(playerctl --player="$player" status)" = "Playing" ]; then
        playerctl --player="$player" pause
        PAUSED_PLAYER=$player
      fi
    done
}

unmute() {
    amixer -q -D pulse sset Master unmute
}

play() {
    if [ "$PAUSED_PLAYER" != "none" ]; then
      playerctl --player="$PAUSED_PLAYER" play
    fi
}

on_startup() {
    disable_bluetooth
    mute_speakers
}

on_lock() {
    disable_bluetooth
    close_jetbrains_toolbox
    mute
    pause
}

on_unlock() {
    unmute
    mute_speakers
    play
}

on_headphone_unplug() {
    mute_speakers
    pause
}

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver',member='ActiveChanged'" |
    while read x; do
        case "$x" in
            *"true"*)
                on_lock;;
            *"false"*)
                on_unlock;;
        esac
    done &

acpi_listen |
    while read line; do
        if [ "$line" = "jack/headphone HEADPHONE unplug" ]; then
            on_headphone_unplug
        fi
    done &

on_startup
