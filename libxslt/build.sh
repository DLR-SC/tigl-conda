#!/bin/bash

./configure --without-crypto -without-python --prefix=$PREFIX
make -j $CPU_COUNT
make install

