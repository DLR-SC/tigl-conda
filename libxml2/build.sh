#!/bin/bash

export CC=$PREFIX/bin/gcc
export CXX=$PREFIX/bin/g++

./configure --without-zlib --prefix=$PREFIX
make -j $CPU_COUNT
make install

