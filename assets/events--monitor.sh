#!/bin/bash

FILE_PLAYER_PAUSED=/tmp/events-monitor--player-paused

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
    xdotool search --name Private | xargs -L 1 xdotool windowminimize
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

    if [ "$PAUSED_PLAYER" != "none" ]; then
        echo "$PAUSED_PLAYER" > $FILE_PLAYER_PAUSED
    fi
}

play() {
    if [[ -f $FILE_PLAYER_PAUSED ]]; then
        PAUSED_PLAYER="$(cat $FILE_PLAYER_PAUSED)"
        rm $FILE_PLAYER_PAUSED

        playerctl --player="$PAUSED_PLAYER" play
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

dbus-monitor --session "interface='org.cinnamon.ScreenSaver',member='Lock'" |
    while read line; do
        case "$line" in
            *"Lock"*)
                on_lock;;
        esac
    done &

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver',member='ActiveChanged'" |
    while read line; do
        case "$line" in
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
