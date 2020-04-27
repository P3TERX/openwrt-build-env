#=================================================
# https://github.com/P3TERX/openwrt-build-env
# Description: OpenWrt build environment in docker
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================
ARG IMAGE_TAG=latest
FROM p3terx/ubuntu-plus:$IMAGE_TAG

USER root

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && \
    apt-get upgrade -qqy && \
    apt-get install -qqy build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib g++-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler antlr3 gperf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER user
WORKDIR /home/user
