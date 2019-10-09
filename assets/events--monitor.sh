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
    close_jetbrains_toolbox
}

on_lock() {
    disable_bluetooth
    close_jetbrains_toolbox
    mute
    pause
}

on_unlock() {
    unmute
    play
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

on_startup
