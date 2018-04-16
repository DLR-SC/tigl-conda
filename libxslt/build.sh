#!/bin/bash

export LDFLAGS="-lrt -Wl,--wrap=memcpy"
./configure --without-crypto --prefix=$PREFIX
make -j $CPU_COUNT
make install

