# https://github.com/P3TERX/openwrt-build-env
# OpenWrt build environment in docker
# MIT License
# Copyright (c) 2020 P3TERX <https://p3terx.com>

ARG BASE_IMAGE_TAG=20.04
FROM linuxplus/ubuntu:${BASE_IMAGE_TAG}

USER root

ARG DEBIAN_FRONTEND=noninteractive
ARG DEPENDS_LIST=depends-ubuntu-2004

RUN apt-get update -qq && \
    apt-get upgrade -qqy && \
    apt-get install -qqy $(curl -fsSL git.io/${DEPENDS_LIST}) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER user
WORKDIR /home/user
