#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_asdf_install_and_set_global gradle "$(asdf list-all gradle | grep -v '[a-z]' | grep '^5' | tail -1)"
my_asdf_install_and_set_global java "$(asdf list-all java | grep openjdk-8 | grep -v 'openj9' | tail -1)"
my_asdf_install_and_set_global maven "$(asdf list-all maven | grep -v '[a-z]' | tail -1)"
my_asdf_install_and_set_global nodejs "$(asdf list-all nodejs | grep '^12' | tail -1)"
