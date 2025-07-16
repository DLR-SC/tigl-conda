#!/bin/bash

export CFLAGS="${CFLAGS} -D_LARGEFILE64_SOURCE=1"
export CXXFLAGS="$CXXFLAGS -std=gnu++98"

# Build step 
make -j $CPU_COUNT -f Makefile.fip libfreeimageplus.a

mkdir -p $PREFIX/include
cp Source/FreeImage.h $PREFIX/include
cp Wrapper/FreeImagePlus/FreeImagePlus.h $PREFIX/include
mkdir -p $PREFIX/lib
cp *.a $PREFIX/lib
cd $PREFIX/lib
ln -s libfreeimageplus.a libfreeimage.a

