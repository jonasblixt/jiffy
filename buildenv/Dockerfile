FROM debian:jessie

RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    wget \
    cpio \
    python \
    unzip \
    rsync \
    bc \
    git \
    device-tree-compiler \
    python-Crypto \
    python-wand \
    libncurses5-dev \
    python3 \
&& rm -rf /var/lib/apt/lists/* \
&& curl -sL https://releases.linaro.org/components/toolchain/binaries/5.3-2016.05/arm-linux-gnueabihf/gcc-linaro-5.3.1-2016.05-x86_64_arm-linux-gnueabihf.tar.xz | tar xJv -C /opt 

