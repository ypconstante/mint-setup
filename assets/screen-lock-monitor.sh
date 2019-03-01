#!/bin/bash

disable_bluetooth() {
    pkill blueman-applet
    pkill blueman-manager
    rfkill block bluetooth
}

close_jetbrains_toolbox() {
    pkill jetbrains-toolb
}

run() {
    disable_bluetooth
    close_jetbrains_toolbox
}

run

dbus-monitor --session "type='signal',interface='org.cinnamon.ScreenSaver'" |
    while read x; do
        case "$x" in
            *"boolean true"*)
                run;;
        esac
    done
