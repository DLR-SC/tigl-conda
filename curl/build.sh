#!/bin/bash

./configure --without-ssl --prefix=$PREFIX
make -j $CPU_COUNT
make install
