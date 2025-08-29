#!/bin/bash

export LDFLAGS="-lrt -Wl,--wrap=memcpy"
./configure --without-crypto --without-zlib -without-python --prefix=$PREFIX
make -j $CPU_COUNT
make install

