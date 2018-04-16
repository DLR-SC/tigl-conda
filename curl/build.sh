#!/bin/bash

if [ `uname` == Darwin ]; then
    ./configure --without-ssl --prefix=$PREFIX
else
    # link against rt, to lower glibc dependency to 2.14 (instead if 2.17)
    LIBS=-lrt ./configure --without-ssl --prefix=$PREFIX
fi

make -j $CPU_COUNT
make install
