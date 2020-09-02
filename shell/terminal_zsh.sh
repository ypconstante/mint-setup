#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install zsh"
my_apt_install zsh
my_step_end

my_step_begin "install starship"
starship_compressed_file=/tmp/starship.tar.gz
starship_file=$HOME/.local/bin/starship
starship_url=$( \
    curl -sS https://api.github.com/repos/starship/starship/releases/latest \
    | jq '[ .assets[].browser_download_url ]' \
    | jq '[ .[] | select(endswith("linux-gnu.tar.gz")) ]' \
    | jq -r 'first' \
)

curl -L "$starship_url" -o "$starship_compressed_file"
tar -xzf "$starship_compressed_file"  -C "$HOME/.local/bin" starship
chmod +x "$starship_file"
my_link_file "$ASSETS_DIR/terminal_zsh--starship.toml" "$XDG_CONFIG_HOME/starship.toml"
rm "$starship_compressed_file"
my_step_end

my_step_begin "install zgen"
my_git_clone https://github.com/tarjoilija/zgen.git "$ZDOTDIR/zgen"
my_step_end

my_step_begin "configure zsh"
my_append_to_file_if_not_contains /etc/shells "$(which zsh)"
sudo chsh -s "$(command -v zsh)" "$USER"
my_link_file "$ASSETS_DIR/base--env" "$ZDOTDIR/.zshenv"
my_link_file "$ASSETS_DIR/terminal_zsh--rc" "$ZDOTDIR/.zshrc"
my_step_end

my_step_begin "remove zsh checks in not used vcs"
sudo find /usr/share/zsh/functions/VCS_Info/Backends -type f -not -name '*_git*' -delete
my_step_end

my_step_begin "install zsh plugins"
zsh -i -c 'zgen update' &> /dev/null
my_step_end
