#!/bin/bash

STEP="install tig"
apt install -y -qq tig
echo "done: $STEP"

STEP="create ssh folder"
mkdir -p -m 700 ~/.ssh
echo "done: $STEP"

STEP="add github and gitlab as known ssh hosts"
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
ssh-keyscan -t rsa gitlab.com >> ~/.ssh/known_hosts
echo "done: $STEP"

STEP="create gitignore"
curl -sS https://www.gitignore.io/api/git,linux,sublimetext,jetbrains+all,visualstudiocode -o ~/projects/gitignore.gitignore
git config --global core.excludesfile '~/projects/gitignore.gitignore'
echo "done: $STEP"

STEP="git config"
git config --global core.fileMode false
echo "done: $STEP"
