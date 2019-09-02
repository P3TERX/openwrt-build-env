FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y wget curl vim nano htop tmux sudo ca-certificates zsh uuid-runtime \
	&& apt-get install -y build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& useradd -m p3terx \
	&& echo p3terx:p3terx | chpasswd \
	&& echo 'p3terx ALL=NOPASSWD: ALL' > /etc/sudoers.d/p3terx \
	&& cd /home/p3terx \
	&& git clone git://github.com/robbyrussell/oh-my-zsh ./.oh-my-zsh \
	&& cp /home/p3terx/.oh-my-zsh/templates/zshrc.zsh-template ./.zshrc \
	&& git clone git://github.com/zsh-users/zsh-syntax-highlighting ./.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
	&& git clone git://github.com/zsh-users/zsh-autosuggestions ./.oh-my-zsh/custom/plugins/zsh-autosuggestions \
	&& sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/g' .zshrc \
	&& sed -i 's/plugins=(git)/plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions)/g' .zshrc \
	&& sed -i 's/# DISABLE_AUTO_UPDATE/DISABLE_AUTO_UPDATE/g' .zshrc \
	&& chown -R p3terx:p3terx /home/p3terx \
	&& cp -R ./.oh-my-zsh/ /root/ \
	&& cp ./.zshrc /root \
	&& sed -i 's/\/home\/p3terx:/\/home\/p3terx:\/bin\/zsh/g' /etc/passwd \
	&& echo "set -g mouse on" >> /home/p3terx/.tmux.conf \
	&& sudo ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& sudo dpkg-reconfigure -f noninteractive tzdata

USER p3terx
WORKDIR /home/p3terx/openwrt