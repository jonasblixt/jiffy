FROM debian:jessie

ENV PATH="/opt/gcc-linaro-7.1.1-2017.08-x86_64_arm-linux-gnueabihf/bin:${PATH}"

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
    libssl-dev \
    u-boot-tools \
    libusb-1.0.0-dev \
    pkg-config \
    vim-common \
    flex \
    bison \
    git \
&& rm -rf /var/lib/apt/lists/* \
&& curl -sL https://releases.linaro.org/components/toolchain/binaries/7.1-2017.08/arm-linux-gnueabihf/gcc-linaro-7.1.1-2017.08-x86_64_arm-linux-gnueabihf.tar.xz | tar xJv -C /opt \
&& git clone https://github.com/boundarydevices/imx_usb_loader.git /tmp/imxloader && cd /tmp/imxloader && make && make install && rm -rf /tmp/imxloader


