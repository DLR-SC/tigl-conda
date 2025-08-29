#!/bin/bash

export LDFLAGS="-lrt -Wl"
./configure --without-crypto --without-zlib -without-python --prefix=$PREFIX
make -j $CPU_COUNT
make install

