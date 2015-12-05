#!/bin/bash

make -j $CPU_COUNT

mkdir -p $PREFIX/lib

mkdir -p $PREFIX/include

# filter libtbb.dylib ( or .so ), libtbbmalloc.dylib ( or .so )
cp `find . -name "*lib*" | grep tbb | grep release` $PREFIX/lib

# copy the include files
cp -r ./include/tbb $PREFIX/include

