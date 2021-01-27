FROM ubuntu:focal

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qy \
    apt-utils \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    ca-certificates \
    cpio \
    curl \
    debianutils \
    file \
    g++ \
    gcc \
    git-all \
    graphviz \
    gzip \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5 \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    locales \
    make \
    patch \
    perl \
    pkg-config \
    pv \
    python \
    python3 \
    python3-pip \
    rsync \
    sed \
    sudo \
    tar \
    tk-dev \
    unzip \
    wget \
    wget \
    xz-utils \
    zlib1g-dev \
    zsh \
    autoconf automake libtool-bin libtool bison help2man gawk texinfo flex

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install pipenv

RUN sed -i "s/^# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen && locale-gen && update-locale LANG=en_US.UTF-8

RUN echo "ALL ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN echo "root:root" | chpasswd

COPY pyenv.env /opt
COPY pyenv-install.sh /opt

RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/pip3 /usr/bin/pip


#ENTRYPOINT [ "entrypoint.sh" ]
