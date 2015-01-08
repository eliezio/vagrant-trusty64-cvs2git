#!/usr/bin/env bash

set -e -x

if [ ! -x /usr/local/bin/cvs-fast-export ]; then
    pushd $(mktemp -d)
    git clone --branch 1.29 --depth 1 https://gitorious.org/cvs-fast-export/cvs-fast-export.git
    cd cvs-fast-export
    sudo make install-bin
    popd
fi

if [ ! -x /usr/local/bin/l1u8recode ]; then
    pushd $(mktemp -d)
    git clone --branch v1.0.0 --depth 1 https://github.com/eliezio/latin1-to-utf8.git
    cd latin1-to-utf8
    mkdir -p Release
    cd Release
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make
    ctest
    sudo make install
    popd
fi

