#!/bin/bash

source "$(dirname "$0")/_base.sh"

get_profile_dir() {
	find ~/.mozilla/firefox -maxdepth 1 -name '*.default' | head -n 1
}

my_step_begin "create firefox profile"
if [[ ! -d $(get_profile_dir) ]]; then
	firefox -CreateProfile default
fi
my_step_end

my_step_begin "config firefox"
cp $ASSETS_DIR/browser_firefox--search.json.mozlz4 "$(get_profile_dir)/search.json.mozlz4"
cp $ASSETS_DIR/browser_firefox--user.js "$(get_profile_dir)/user.js"

mkdir -p "$(get_profile_dir)/chrome"
cp $ASSETS_DIR/browser_firefox--userChrome.css "$(get_profile_dir)/chrome/userChrome.css"
cp $ASSETS_DIR/browser_firefox--userContent.css "$(get_profile_dir)/chrome/userContent.css"

mkdir -p "$(get_profile_dir)/browser-extension-data/treestyletab@piro.sakura.ne.jp"
cp $ASSETS_DIR/browser_firefox--treeStyleTab.js "$(get_profile_dir)/browser-extension-data/treestyletab@piro.sakura.ne.jp/storage.js"
my_step_end
