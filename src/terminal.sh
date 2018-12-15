#!/bin/bash

source "$(dirname "$0")/_base.sh"

STEP="configure terminal theme"
dset() {
    local key="$1"
    local val="$2"

    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/" $key "$val"
}

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default)
PROFILE_ID=${PROFILE_ID:1:-1}

# colors from darcula and one dark syntax
color_background="'#1b1b1b'"
color_foreground="'#bbbbbb'"
color_red="'#be5046'"
color_green="'#98c379'"
color_yellow="'#d19a66'"
color_blue="'#61afef'"
color_pink="'#c678dd'"
color_cyan="'#56b6c2'"
color_light_gray="'#d0d0d0'"
color_medium_gray="'#808080'"
color_white="'#ffffff'"

dset palette "[$color_background, $color_red, $color_green, $color_yellow, $color_blue, $color_pink, $color_cyan, $color_light_gray, $color_medium_gray, $color_red, $color_green, $color_yellow, $color_blue, $color_pink, $color_cyan, $color_white]"
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
echo "done: $STEP"

STEP="configure terminal shortcuts"
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
echo "done: $STEP"

STEP="install zsh"
my_apt_install zsh
echo "done: $STEP"

export ZDOTDIR=$HOME/.local/share/zsh

STEP="install zgen"
git clone https://github.com/tarjoilija/zgen.git $ZDOTDIR/zgen
echo "done: $STEP"

STEP="install additional cli tools"
my_apt_install autojump
my_apt_install inotify-tools
my_apt_install jq
echo "done: $STEP"

STEP="install thefuck"
my_apt_install python3-dev python3-pip python3-setuptools
my_pip_install wheel
my_pip_install thefuck
echo "done: $STEP"

STEP="configure zsh"
which zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
cp $ASSETS/terminal.zshrc $ZDOTDIR/.zshrc
echo "ZDOTDIR=$ZDOTDIR" > $HOME/.pam_environment
echo "done: $STEP"

STEP="install zsh plugins"
echo "starting: $STEP"
zsh -i -c true
echo "done: $STEP"
