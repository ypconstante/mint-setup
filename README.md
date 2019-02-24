# Steps

Setup Timeshift

Create Timeshift snapshot

```sh
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update -y -qq
sudo apt install -y -qq git
git clone https://github.com/ypconstante/mint-setup.git ~/projects/personal/mint-setup
find ./projects/personal/mint-setup/. -name "*.sh" -exec chmod +x {} \;
./projects/personal/mint-setup/shell/prepare.sh
```

Update kernel

Restart computer

Choose drivers

```sh
./projects/personal/mint-setup/shell/main.sh
```

Sign in or add license to:
- Chrome
- Firefox
- Franz
- JetBrains Toolbox
- Spotify
- Sublime Merge
- Sublime Text

Install:
- IntelliJ
- DataGrip

Install packages using asdf:
- gradle
- java
- maven
- nodejs

Configure Firefox extensions:
- Auto Discard Tabs
- Stylus
- uBlock
- uMatrix
- Violentmonkey

Configure git:
- `git config --global user.email "you@example.com"`
- `git config --global user.name "Your Name"`
- [Create key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)

Configure packages:
- gradle
- maven
- npm
