#!/bin/bash

source "$(dirname "$0")/_base.sh"

asdf_install_and_set_global() {
    local package="$1"
    local version="$2"
    my_step_begin "install $package"
    echo "installing $package version $version"
    asdf install "$package" "$version"
    asdf global "$package" "$version"
    my_step_end
}

set +o nounset
source "$XDG_DATA_HOME/asdf/asdf.sh"
asdf_install_and_set_global gradle "$(asdf list-all gradle | grep -v '[a-z]' | grep '^5' | tail -1)"
asdf_install_and_set_global java "$(asdf list-all java | grep openjdk | tail -1)"
asdf_install_and_set_global maven "$(asdf list-all maven | grep -v '[a-z]' | tail -1)"
asdf_install_and_set_global nodejs "$(asdf list-all nodejs | grep '^10' | tail -1)"
asdf_install_and_set_global nodejs "$(asdf list-all nodejs | grep '^12' | tail -1)"
