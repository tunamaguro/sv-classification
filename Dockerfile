# 参考  https://zenn.dev/mosamosa/articles/b187cb5380be87
FROM nvidia/cuda:11.7.0-cudnn8-devel-ubuntu20.04

ENV TZ=Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive=value

RUN apt update \
    && apt install -y \
    wget \
    bzip2 \
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
    # make \
    unzip \
    # ffmpeg \
    file \
    xz-utils \
    sudo \
    python3-tk \
    python3 \
    python3-pip

# remove cache files
RUN apt-get autoremove -y && apt-get clean && \
    rm -rf /usr/local/src/*

COPY ./requirements.txt /tmp/reqirements.txt

RUN pip install --no-cache-dir --upgrade pip setuptools \
    && pip install --no-cache-dir -r /tmp/reqirements.txt

# nodejsの導入
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

## JupyterLabの拡張機能

# 変数や行列の中身を確認
RUN jupyter labextension install @lckr/jupyterlab_variableinspector@3.0.7

# 自動整形
RUN pip install autopep8 \
    && pip install jupyterlab_code_formatter \
    && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
    && jupyter serverextension enable --py jupyterlab_code_formatter

# jupyter の config ファイルの作成
RUN mkdir /mlws && echo "c.NotebookApp.notebook_dir = '/mlws' \n" | tee -a ${HOME}/.jupyter/jupyter_notebook_config.py
