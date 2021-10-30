# syntax=docker/dockerfile:1.3-labs
ARG BASE_IMAGE=arm32v7/python:3.7.12-buster
FROM ${BASE_IMAGE}

RUN <<EOF
    apt-get update
    apt-get install -y \
        build-essential \
        cmake \
        git
EOF

ARG PYTORCH_VERSION=v1.10.0
RUN <<EOF
    git clone --recursive https://github.com/pytorch/pytorch.git
    cd pytorch

    git checkout "${PYTORCH_VERSION}"

    git submodule sync
    git submodule update --init --recursive --jobs 0
EOF

RUN <<EOF
    cd pytorch
    python3 -m pip install -U pip setuptools wheel
    pip3 install -r requirements.txt
EOF

RUN <<EOF
    apt-get update
    apt-get install -y \
        libopenblas-dev \
        libblas-dev \
        m4 \
        cython
EOF

WORKDIR /pytorch
