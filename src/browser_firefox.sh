#!/bin/bash

source "$(dirname "$0")/_base.sh"

get_profile_dir() {
	find ~/.mozilla/firefox -maxdepth 1 -name '*.default' | head -n 1
}

STEP="create firefox profile"
if [[ ! -d $(get_profile_dir) ]]; then
	firefox -CreateProfile default
fi
echo "done: $STEP"

STEP="config firefox"
cp files/firefox-search.json.mozlz4 "$(get_profile_dir)/search.json.mozlz4"
cp files/firefox-user.js "$(get_profile_dir)/user.js"

mkdir -p "$(get_profile_dir)/chrome"
cp files/firefox-userChrome.css "$(get_profile_dir)/chrome/userChrome.css"

mkdir -p "$(get_profile_dir)/browser-extension-data/treestyletab@piro.sakura.ne.jp"
cp files/firefox-treeStyleTab.js "$(get_profile_dir)/browser-extension-data/treestyletab@piro.sakura.ne.jp/storage.js"
echo "done: $STEP"
