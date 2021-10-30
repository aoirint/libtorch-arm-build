# syntax=docker/dockerfile:1.3-labs
FROM arm32v7/ubuntu:bionic

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
    apt-get update
    apt-get install -y \
        python3 \
        python3-pip

    python3 -m pip install -U pip setuptools wheel
EOF

RUN <<EOF
    cd pytorch
    pip3 install -r requirements.txt

    mkdir build_libtorch
    cd build_libtorch
    python3 ../tools/build_libtorch.py
EOF
