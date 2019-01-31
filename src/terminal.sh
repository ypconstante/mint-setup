#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "configure terminal theme"
dset() {
    local key="$1"
    local val="$2"

    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/" $key "$val"
}

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default)
PROFILE_ID=${PROFILE_ID:1:-1}

# colors from darcula and monokai
color_red="'#ff6188'"
color_green="'#a9dc76'"
color_yellow="'#ffd866'"
color_blue="'#66d9ef'"
color_purple="'#ab9df2'"
color_cyan="'#78dce8'"
color_completion="'#9e9c8b'"
color_white="'#f8f8f2'"
color_background="'#2f2f2f'"
color_foreground="$color_white"

dset palette "[$color_background, $color_red, $color_green, $color_yellow, $color_blue, $color_purple, $color_cyan, $color_white, $color_completion, $color_red, $color_green, $color_yellow, $color_blue, $color_purple, $color_cyan, $color_white]"
dset background-color "$color_background"
dset foreground-color "$color_foreground"
dset bold-color "$color_foreground"
dset bold-color-same-as-fg true
dset cursor-colors-set true
dset cursor-background-color "$color_foreground"
dset cursor-foreground-color "$color_background"
dset use-theme-colors false
dset use-theme-transparency false
dset use-transparent-background false

dconf write /org/gnome/terminal/legacy/default-show-menubar false
my_step_end

my_step_begin "configure terminal shortcuts"
dconf write /org/gnome/terminal/legacy/keybindings/new-tab "'<Primary>t'"
dconf write /org/gnome/terminal/legacy/keybindings/new-window "'<Primary>n'"
dconf write /org/gnome/terminal/legacy/keybindings/close-tab "'<Primary>w'"
dconf write /org/gnome/terminal/legacy/keybindings/zoom-in "'<Primary>equal'"
dconf write /org/gnome/terminal/legacy/keybindings/find "'<Primary>f'"
dconf write /org/gnome/terminal/legacy/keybindings/find-next "'<Primary>g'"
dconf write /org/gnome/terminal/legacy/keybindings/find-previous "'<Primary>h'"
dconf write /org/gnome/terminal/legacy/keybindings/find-clear "'<Primary>j'"
dconf write /org/gnome/terminal/legacy/keybindings/next-tab "'<Primary>Tab'"
dconf write /org/gnome/terminal/legacy/keybindings/prev-tab "'<Primary><Shift>Tab'"
my_step_end

my_step_begin "install zsh"
my_apt_install zsh
my_step_end

my_step_begin "install zgen"
git clone https://github.com/tarjoilija/zgen.git $ZDOTDIR/zgen
my_step_end

my_step_begin "install additional cli tools"
my_apt_install autojump
my_apt_install inotify-tools
my_apt_install jq
my_step_end

my_step_begin "install thefuck"
my_apt_install python3-dev python3-pip python3-setuptools
my_pip_install wheel
my_pip_install thefuck
my_step_end

my_step_begin "configure zsh"
my_append_to_file_if_not_contains /etc/shells $(which zsh)
sudo chsh -s $(which zsh) $USER
sed 's/^export \([^=]*\)/\1 DEFAULT/g' $ASSETS_DIR/base--env > $HOME/.pam_environment
my_link_file $ASSETS_DIR/base--env $ZDOTDIR/.zshenv
my_link_file $ASSETS_DIR/terminal.zshrc $ZDOTDIR/.zshrc
my_step_end

my_step_begin "install zsh plugins"
zsh -i -c true
my_step_end
