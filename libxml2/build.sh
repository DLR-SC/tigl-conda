#!/bin/bash

./configure --without-zlib --without-lzma --without-python --prefix=$PREFIX
make -j $CPU_COUNT
make install

