# Steps

Setup Timeshift

Create Timeshift snapshot

Update kernel

Restart computer

Choose drivers

```sh
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update -y -qq
sudo apt install -y -qq git
git clone https://github.com/ypconstante/mint-setup.git ~/projects/personal/mint-setup
find ./projects/personal/mint-setup/. -name "*.sh" -exec chmod +x {} \;
./projects/personal/mint-setup/shell/prepare.sh
```

Restart computer

Create Timeshift snapshot

```sh
./projects/personal/mint-setup/shell/main.sh
```

Sign in or add license to:
- Chromium
- Firefox
- Franz
- JetBrains Toolbox
- Spotify
- Sublime Merge
- Sublime Text

Install:
- IntelliJ
- DataGrip

Configure Firefox extensions:
- Auto Discard Tabs
- Stylus
- Temporary Containers
- Tree Style Tab
- uBlock
- uMatrix
- Violentmonkey

Add certificates to firefox
- /usr/local/share/ca-certificates

Configure git:
- `git config --global user.email "you@example.com"`
- `git config --global user.name "Your Name"`
- [Create key](https://github.com/ypconstante/mint-setup/wiki#create-ssh-key)

Configure packages:
- gradle
- maven
- npm
