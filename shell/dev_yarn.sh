#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install yarn"
my_apt_add_key https://dl.yarnpkg.com/debian/pubkey.gpg
my_apt_add_repository yarn "deb https://dl.yarnpkg.com/debian/ stable main"
my_apt_install yarn --no-install-recommends
my_step_end
