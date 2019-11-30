#=================================================
# Description: OpenWrt build environment in docker
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
ARG IMAGE_TAG
FROM p3terx/ubuntu-plus:${IMAGE_TAG:-latest}

LABEL maintainer P3TERX

ENV DEBIAN_FRONTEND noninteractive

RUN sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get install -y build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler && \
    sudo apt-get clean && \
    sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
