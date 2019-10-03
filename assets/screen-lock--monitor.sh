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

unmute() {
    amixer -q -D pulse sset Master unmute
}

on_start() {
    disable_bluetooth
    close_jetbrains_toolbox
}

on_lock() {
    disable_bluetooth
    close_jetbrains_toolbox
    mute
}

on_unlock() {
    unmute
}

on_start

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver',member='ActiveChanged'" |
    while read x; do
        case "$x" in
            *"true"*)
                on_lock;;
            *"false"*)
                on_unlock;;
        esac
    done
