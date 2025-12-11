#!/bin/bash

dos2unix Source/**/*.cpp

patch -p1 < $RECIPE_DIR/patches/Use-system-libs.patch
patch -p1 < $RECIPE_DIR/patches/Fix-compatibility-with-system-libpng.patch
patch -p1 < $RECIPE_DIR/patches/CVE-2019-12211-13.patch
patch -p1 < $RECIPE_DIR/patches/freeimage-openexr3.patch
patch -p1 < $RECIPE_DIR/patches/remove_auto_ptr.patch

# remove all included libs to make sure these don't get used during compile
rm -r Source/Lib* Source/ZLib Source/OpenEXR
# clear files which cannot be built due to dependencies on private headers
# (see also unbundle patch)
> Source/FreeImage/PluginG3.cpp
> Source/FreeImageToolkit/JPEGTransform.cpp

mkdir cmake
cp $RECIPE_DIR/cmake/*.cmake cmake

mkdir -p build
cd build

cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_FIND_ROOT_PATH=$PREFIX \
      -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
      -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
      -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
      -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
      -DCMAKE_FIND_FRAMEWORK=NEVER \
      -DCMAKE_FIND_APPBUNDLE=NEVER \
      ..

make VERBOSE=1 -j${CPU_COUNT}
make install

cmake -E create_symlink ${PREFIX}/lib/libfreeimage${SHLIB_EXT} ${PREFIX}/lib/libfreeimage-${PKG_VERSION}${SHLIB_EXT}
