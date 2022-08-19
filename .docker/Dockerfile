# 参考  https://zenn.dev/mosamosa/articles/b187cb5380be87
FROM nvidia/cuda:11.7.0-cudnn8-devel-ubuntu20.04

ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive=value

RUN apt update \
    && apt install -y \
    wget \
    make \
    cmake \
    # ca-certificates \
    # libglib2.0-0 \
    # libxext6 \
    # libsm6 \
    # libxrender1 \
    git \
    # mercurial \
    # subversion \
    # zsh \
    # openssh-server \
    # gcc \
    # g++ \
    # libatlas-base-dev \
    # libboost-dev \
    # libboost-system-dev \
    # libboost-filesystem-dev \
    curl \
    unzip \
    # ffmpeg \
    file \
    xz-utils \
    sudo \
    python3-tk \
    python3 \
    python3-pip

# nodejsの導入
RUN curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

# jupyter lab-kite
RUN cd && \
    wget https://linux.kite.com/dls/linux/current && \
    chmod 777 current && \
    sed -i 's/"--no-launch"//g' current > /dev/null && \
    ./current --install ./kite-installer

COPY ./requirements.txt /tmp/reqirements.txt

RUN pip install --no-cache-dir --upgrade pip setuptools \
    && pip install --no-cache-dir -r /tmp/reqirements.txt

# jupyter lab extension
RUN jupyter labextension install  @jupyterlab/toc

# remove cache files
RUN apt-get autoremove -y && apt-get clean && \
    rm -rf /usr/local/src/*