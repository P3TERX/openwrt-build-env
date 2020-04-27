# openwrt-build-env

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=License)](https://github.com/P3TERX/openwrt-build-env/blob/master/LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/P3TERX/openwrt-build-env.svg?style=flat-square&label=Stars&logo=github)](https://github.com/P3TERX/openwrt-build-env/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/P3TERX/openwrt-build-env.svg?style=flat-square&label=Forks&logo=github)](https://github.com/P3TERX/openwrt-build-env/fork)
[![Docker Stars](https://img.shields.io/docker/stars/p3terx/openwrt-build-env.svg?style=flat-square&label=Stars&logo=docker)](https://hub.docker.com/r/p3terx/openwrt-build-env)
[![Docker Pulls](https://img.shields.io/docker/pulls/p3terx/openwrt-build-env.svg?style=flat-square&label=Pulls&logo=docker&color=orange)](https://hub.docker.com/r/p3terx/openwrt-build-env)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/P3TERX/openwrt-build-env/Docker%20images%20publish?label=Actions&logo=github&style=flat-square)

OpenWrt build environment in docker.

[Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-docker.html)

## Usage

### Pull or build image

- Pull image from docker hub.
  
  ```shell
  docker pull p3terx/openwrt-build-env
  ```

- Build image.
  
  ```shell
  docker build -t p3terx/openwrt-build-env github.com/P3TERX/openwrt-build-env
  ```

### Run container

```shell
docker run \
    -itd \
    --name openwrt-build-env \
    -h P3TERX \
    -p 10022:22 \
    -v ~/openwrt:/home/user/openwrt \
    p3terx/openwrt-build-env
```

### Set the mount directory file permissions

- Enter the `id` command to check UID and GID
  
  ```shell
  $ id
  uid=1001(p3terx) gid=1002(p3terx)
  ```

- Modify the UID and GID
  
  ```shell
  docker exec openwrt-build-env sudo usermod -u 1001 user
  docker exec openwrt-build-env sudo groupmod -g 1002 user
  ```

- Modify the file ownership
  
  ```shell
  docker exec openwrt-build-env sudo chown -hR user:user .
  ```

- Restart container
  
  ```shell
  docker restart openwrt-build-env
  ```

### SSH security settings

The default SSH user name and password is `user`. If you are making the container accessible from the internet you'll probably want to secure it bit. You can do one of the following two things after launching the container:

- Change password:
  
  ```shell
  docker exec -it openwrt-build-env sudo passwd user
  ```

- Don't allow passwords at all, use keys instead:
  
  ```shell
  docker cp ~/.ssh/authorized_keys openwrt-build-env:/home/user/.ssh
  docker exec openwrt-build-env sudo chown user:user /home/user/.ssh/authorized_keys
  docker exec openwrt-build-env sudo sed -i '/PasswordAuthentication /c\PasswordAuthentication no' /etc/ssh/sshd_config
  docker restart openwrt-build-env
  ```

### Enter container

- Enter from the host.
  
  ```shell
  docker exec -it openwrt-build-env zsh
  ```

- Connect via SSH.
  
  ```shell
  ssh user@IP -p 10022
  ```

### Clone source code and build

```shell
git clone https://github.com/openwrt/openwrt
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a
make menuconfig
make download -j8
make V=s
```
