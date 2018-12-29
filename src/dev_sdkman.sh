#!/bin/bash

source "$(dirname "$0")/_base.sh"

my_step_begin "install sdkman"
sdkman_script="$HOME/sdkman_script.sh"

curl -sS 'https://get.sdkman.io' -o $sdkman_script

sed -i "s/\(echo ' .*\)/# \1/g" $sdkman_script
sed -i "s/\(echo ''\)/# \1/g" $sdkman_script
sed -i 's/\(echo ""\)/# \1/g' $sdkman_script

export SDKMAN_DIR=$XDG_DATA_HOME/sdkman
bash $sdkman_script

rm ~/.zshrc
rm $sdkman_script
my_step_end
