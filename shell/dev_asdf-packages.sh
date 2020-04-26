#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install asdf plugins"
# disable variable check since it's a external script
set +o nounset
source "$XDG_DATA_HOME/asdf/asdf.sh"
asdf plugin-add golang
asdf plugin-add gradle https://github.com/ypconstante/asdf-gradle
asdf plugin-add java
asdf plugin-add maven
asdf plugin-add nodejs
asdf plugin-add python
asdf plugin-add shellcheck
asdf plugin-add yarn
asdf plugin-update --all
my_step_end

my_step_begin "import nodejs keys"
source "$ASDF_DATA_DIR/plugins/nodejs/bin/import-release-team-keyring" &> /dev/null
my_step_end

my_asdf_install_and_set_global golang "$(asdf list-all golang | grep -v '[a-z]' | tail -1)"
my_asdf_install_and_set_global gradle "$(asdf list-all gradle | grep -v '[a-z]' | grep '^5' | tail -1)"
my_asdf_install_and_set_global java "$(asdf list-all java | grep openjdk-8 | grep -v 'openj9' | tail -1)"
my_asdf_install_and_set_global maven "$(asdf list-all maven | grep -v '[a-z]' | tail -1)"
my_asdf_install_and_set_global nodejs "$(asdf list-all nodejs | grep '^12' | tail -1)"
my_asdf_install_and_set_global shellcheck "$(asdf list-all shellcheck | tail -1)"
my_asdf_install_and_set_global yarn "$(asdf list-all yarn | grep '^1' | tail -1)"
