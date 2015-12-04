#!/bin/bash

./configure --without-zlib --prefix=$PREFIX
make -j $CPU_COUNT
make install

