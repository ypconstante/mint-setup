# Install

```sh
curl -L 'https://github.com/ypconstante/mint-setup/archive/master.zip' -o 'mint-setup.zip'
unzip 'mint-setup.zip'
find mint-setup-master/. -name "*.sh" -exec chmod +x {} \;
sudo ./mint-setup-master/shell/install.sh
```

After installing, select 'Continue Testing'.


# After install

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
- Sublime Merge
- Sublime Text

Configure Chromium:
- Sign in
- Disable system titlebar
- Change search engine to DDG

Configure Firefox:
- Sign in
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
- Change sync config
    - Enable Add-ons
    - Disable credit cards

Configure JetBrains Toolbox:
- Sign in
- Install IntelliJ

Configure Spotify
- Sign in
- Download liked songs
- In 'Settings > Display Options', disable notifications
- In 'Settings > Privacy', disable cookies

Configure packages:
- gradle
- maven
- npm

[Install video drivers](https://github.com/lutris/docs/blob/master/InstallingDrivers.md)

Create Timeshift snapshot
