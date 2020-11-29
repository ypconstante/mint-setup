# Steps

Setup Timeshift

Create Timeshift snapshot

Update kernel

Restart computer

Choose drivers

Install and configure git:
```sh
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update -y -qq
sudo apt install -y -qq git
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

[Create git key](https://github.com/ypconstante/mint-setup/wiki#create-ssh-key)

```sh
git clone git@github.com:ypconstante/mint-setup.git ~/projects/personal/mint-setup
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


Configure Chromium:
- Enable system titlebar

Configure Firefox:
- Change theme to dark compact
- Extensions:
    - Auto Discard Tabs
    - Cookie AutoDelete
    - Stylus
    - Temporary Containers
    - Tree Style Tab
    - uBlock
    - uMatrix
    - Violentmonkey
- Add certificates from /usr/local/share/ca-certificates

Configure Spotify
- Download liked songs
- In 'Settings > Display Options', disable notifications
- In 'Settings > Privacy', disable cookies

Configure packages:
- gradle
- maven
- npm

[Install video drivers](https://github.com/lutris/docs/blob/master/InstallingDrivers.md)

Create Timeshift snapshot
