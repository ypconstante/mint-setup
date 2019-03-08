#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install guake"
my_apt_install guake
my_step_end

my_step_begin "start guake at startup"
my_link_file /usr/share/applications/guake.desktop "$XDG_CONFIG_HOME/autostart/"
my_step_end

my_step_begin "config guake"
dconf write /apps/guake/general/use-popup false
dconf write /apps/guake/general/use-trayicon false
# confirm close tab with process running
dconf write /apps/guake/general/prompt-on-close-tab 1
dconf write /apps/guake/general/window-refocus true
dconf write /apps/guake/general/tab-ontop true
dconf write /apps/guake/general/quick-open-enable true
dconf write /apps/guake/general/quick-open-command-line "'subl %(file_path)s:%(line_number)s'"
my_step_end

my_step_begin "configure terminal theme"
format_color() {
    local result="${1:0:1}"
    for i in 1 3 5; do
        local hex=${1:${i}:2}
        result="$result$hex$hex"
    done
    echo "$result"
}

dconf write /apps/guake/style/font/palette-name "'Custom'"
color_red="$(format_color '#ff6188')"
color_green="$(format_color '#a9dc76')"
color_yellow="$(format_color '#ffd866')"
color_blue="$(format_color '#66d9ef')"
color_purple="$(format_color '#ab9df2')"
color_cyan="$(format_color '#78dce8')"
color_completion="$(format_color '#9e9c8b')"
color_white="$(format_color '#f8f8f2')"
color_background="$(format_color '#2f2f2f')"
color_foreground="$color_white"

dconf write /apps/guake/style/font/palette \
  "'$color_background:$color_red:$color_green:$color_yellow:$color_blue:$color_purple:$color_cyan:$color_white:$color_completion:$color_red:$color_green:$color_yellow:$color_blue:$color_purple:$color_cyan:$color_white:$color_foreground:$color_background'"
my_step_end

my_step_begin "configure guake shortcuts"
dconf write /apps/guake/keybindings/global/show-hide "'F2'"
dconf write /apps/guake/keybindings/local/quit "'disabled'"
dconf write /apps/guake/keybindings/local/new-tab "'<Primary>t'"
dconf write /apps/guake/keybindings/local/close-tab "'<Primary>w'"
dconf write /apps/guake/keybindings/local/switch-tab1 "'<Primary>1'"
dconf write /apps/guake/keybindings/local/switch-tab2 "'<Primary>2'"
dconf write /apps/guake/keybindings/local/switch-tab3 "'<Primary>3'"
dconf write /apps/guake/keybindings/local/switch-tab4 "'<Primary>4'"
dconf write /apps/guake/keybindings/local/switch-tab5 "'<Primary>5'"
dconf write /apps/guake/keybindings/local/switch-tab6 "'<Primary>6'"
dconf write /apps/guake/keybindings/local/switch-tab7 "'<Primary>7'"
dconf write /apps/guake/keybindings/local/switch-tab8 "'<Primary>8'"
dconf write /apps/guake/keybindings/local/switch-tab9 "'<Primary>9'"
dconf write /apps/guake/keybindings/local/switch-tab10 "'<Primary>0'"
my_step_end
