#!/bin/bash

STEP="configure terminal theme"
dset() {
    local key="$1"; shift
    local val="$1"; shift

    if [[ "$type" == "string" ]]; then
        val="'$val'"
    fi

    gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/" $key "$val"
}

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default)
PROFILE_ID=${PROFILE_ID:1:-1}

# colors from snazzy and darcula
dset palette "['#2b2b2b', '#ff5c57', '#5af78e', '#f3f99d', '#57c7ff', '#ff6ac1', '#9aedfe', '#f1f1f0', '#686868', '#ff5c57', '#5af78e', '#f3f99d', '#57c7ff', '#ff6ac1', '#9aedfe', '#eff0eb']"
dset background-color "'#2b2b2b'"
dset foreground-color "'#eff0eb'"
dset bold-color "'#eff0eb'"
dset bold-color-same-as-fg "true"
dset cursor-colors-set "true"
dset cursor-background-color "'#eff0eb'"
dset cursor-foreground-color "'#2b2b2b'"
dset use-theme-colors "false"
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
apt install zsh -y -qq
echo "done: $STEP"

STEP="install zgen"
git clone https://github.com/tarjoilija/zgen.git $HOME/.zgen
echo "done: $STEP"

STEP="install additional cli tools"
apt install autojump
echo "done: $STEP"

STEP="configure zsh"
which zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
cp files/.zshrc ~/.zshrc
echo "done: $STEP"

STEP="install zsh plugins"
zsh -i -c true
echo "done: $STEP"

STEP="compile zsh plugins"
find ~/.zgen -name "*.zsh" -exec zsh -i -c "zcompile {}" \;
echo "done: $STEP"
