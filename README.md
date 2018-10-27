Steps

```sh
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update -y -qq
sudo apt install -y -qq git
git clone https://github.com/ypconstante/mint-setup.git
find ./mint-setup/. -name "*.sh" -exec chmod +x {} \;
./mint-setup/src/prepare.sh
```

Update kernel
Restart computer
Choose drivers


```sh
./mint-setup/src/main.sh
rm -rf mint-setup
```