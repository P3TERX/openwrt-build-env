# openwrt-build-env

OpenWrt build environment in docker.

[中文教程](https://p3terx.com/archives/build-openwrt-with-docker.html)

## Usage

### Pull or build image

```shell
# Pull image from docker hub.
docker pull p3terx/openwrt-build-env
# Build image from github repo.
docker build -t p3terx/openwrt-build-env github.com/P3TERX/openwrt-build-env
```

### Run container

```shell
docker run -itd -v ~/openwrt:/home/p3terx/openwrt --name openwrt-build-env p3terx/openwrt-build-env
docker exec -it openwrt-build-env zsh
sudo chown -R p3terx:p3terx /home/p3terx/openwrt
```

### Clone source code and build

```shell
git clone https://github.com/coolsnowwolf/lede
cd lede
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make download V=s -j8
make -j1 V=s
```