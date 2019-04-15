#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install insomnia"
my_apt_add_key https://insomnia.rest/keys/debian-public.key.asc
my_apt_add_repository insomnia "deb https://dl.bintray.com/getinsomnia/Insomnia /"
my_apt_install insomnia
my_step_end
