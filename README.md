Steps

```sh
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update -y -qq
sudo apt install -y -qq git
git clone https://github.com/ypconstante/mint-setup.git
find ./mint-setup/. -name "*.sh" -exec chmod +x {} \;
./mint-setup/user/prepare.sh
```

Update kernel
Reset

```sh
./mint-setup/system/main.sh
./mint-setup/user/main.sh
rm -rf mint-setup
```