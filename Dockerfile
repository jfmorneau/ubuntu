FROM ubuntu:latest

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -qy \
    apt-utils \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    ca-certificates \
    cpio \
    debianutils \
    file \
    g++ \
    gcc \
    git-all \
    graphviz \
    gzip \
    libncurses5 \
    libncurses5-dev \
    libqt4-dev \
    locales \
    make \
    patch \
    perl \
    pkg-config \
    pv \
    python \
    python3 \
    python-matplotlib \
    qt4-dev-tools \
    rsync \
    sed \
    sudo \
    tar \
    unzip \
    wget \
    zsh

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i "s/^# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && locale-gen && update-locale LANG=en_US.UTF-8

RUN echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]  