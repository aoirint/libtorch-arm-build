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

RUN <<EOF
    git clone --recursive https://github.com/pytorch/pytorch
    cd pytorch

    git submodule sync
    git submodule update --init --recursive --jobs 0
EOF

RUN <<EOF
    cd pytorch
    python3 -m pip install -U pip setuptools wheel
    pip3 install -r requirements.txt
EOF

RUN <<EOF
    cd pytorch
    mkdir build_libtorch
    cd build_libtorch
    python3 ../tools/build_libtorch.py
EOF
