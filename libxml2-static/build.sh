#!/bin/bash

export CFLAGS="-fPIC $CFLAGS -O2 -fno-semantic-interposition"
export CXXFLAGS="-fPIC $CXXFLAGS -O2 -fno-semantic-interposition"
./autogen.sh  --without-zlib --without-lzma --without-python --without-iconv --prefix=$PREFIX --enable-shared=no 
make -j $CPU_COUNT
make install

# remove xml binaries
rm $PREFIX/bin/xmlcatalog $PREFIX/bin/xmllint

