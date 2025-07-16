#!/bin/bash

# The following CFFLAGS are required on macOS for FreeImage to build correctly. Note that this may not be the cleanest solution, but it works.
export CFLAGS="${CFLAGS} -D_LARGEFILE64_SOURCE=1 -Wno-error=implicit-function-declaration"
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

