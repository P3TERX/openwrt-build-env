#=================================================
# Description: OpenWrt build environment in docker
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

FROM ubuntu:18.04

LABEL maintainer P3TERX

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git wget curl vim nano htop tmux sudo ca-certificates zsh command-not-found uuid-runtime tzdata openssh-server && \
    apt-get install -y build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir /var/run/sshd && \
    useradd -m -s /usr/bin/zsh user && \
    echo 'user:user' | chpasswd && \
    echo 'user ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/user && \
    chmod 440 /etc/sudoers.d/user && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

USER user
WORKDIR /home/user

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended && \
    git clone git://github.com/zsh-users/zsh-syntax-highlighting .oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone git://github.com/zsh-users/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-completions .oh-my-zsh/custom/plugins/zsh-completions && \
    echo "autoload -U compinit && compinit" >> .zshrc && \
    sed -i '/^ZSH_THEME=/c\ZSH_THEME="ys"' .zshrc && \
    sed -i '/^plugins=/c\plugins=(git sudo z command-not-found zsh-syntax-highlighting zsh-autosuggestions zsh-completions)' .zshrc && \
    git clone https://github.com/gpakosz/.tmux.git && \
    ln -s -f .tmux/.tmux.conf && \
    cp .tmux/.tmux.conf.local . && \
    mkdir -p ~/.ssh && \
    chmod 700 ~/.ssh

EXPOSE 22

CMD [ "sudo", "/usr/sbin/sshd", "-D" ]
