#!/bin/bash

PAUSED_PLAYER="none"

kill_previous_events_monitor() {
    pgrep events-monitor | grep -v "$$" | xargs kill -9
}

disable_bluetooth() {
    pkill blueman-applet
    pkill blueman-manager
    rfkill block bluetooth
}

close_jetbrains_toolbox() {
    pkill jetbrains-toolb
}

minimize_private_windows() {
    xdotool search --name Private | xargs --no-run-if-empty -L 1 xdotool windowminimize
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

unmute() {
    amixer -q -D pulse sset Master unmute
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

play() {
    if [ "$PAUSED_PLAYER" != "none" ]; then
        playerctl --player="$PAUSED_PLAYER" play
        PAUSED_PLAYER="none"
    fi
}

on_startup() {
    kill_previous_events_monitor
    disable_bluetooth
    mute_speakers
}

on_lock() {
    minimize_private_windows
    mute
    close_jetbrains_toolbox
    disable_bluetooth
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

on_startup

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver',member='ActiveChanged'" |
    while read line; do
        case "$line" in
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
