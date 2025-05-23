#!/bin/sh
set -ex

# The CMake bootstrap build requires an internal version of libuv. If $CFLAGS
# and friends include -I$PREFIX/include, the build picks up the real libuv
# headers first, which breaks the build. The real build adds the needed
# include paths correctly.
export CFLAGS=$(echo "$CFLAGS" |sed -e "s|-I$PREFIX/include||")
export DEBUG_CFLAGS=$(echo "$DEBUG_CFLAGS" |sed -e "s|-I$PREFIX/include||")
export CXXFLAGS=$(echo "$CXXFLAGS -D_LIBCPP_DISABLE_AVAILABILITY" |sed -e "s|-I$PREFIX/include||")
export DEBUG_CXXFLAGS=$(echo "$DEBUG_CXXFLAGS -D_LIBCPP_DISABLE_AVAILABILITY" |sed -e "s|-I$PREFIX/include||")

./bootstrap \
             --verbose \
             --prefix="${PREFIX}" \
             --parallel=${CPU_COUNT} \
             -- \
             -DCMAKE_BUILD_TYPE:STRING=Release \
             -DCMAKE_FIND_ROOT_PATH="${PREFIX}" \
             -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
             -DCURSES_INCLUDE_PATH="${PREFIX}/include" \
             -DCMake_HAVE_CXX_MAKE_UNIQUE:INTERNAL=FALSE \
             -DCMAKE_PREFIX_PATH="${PREFIX}" \
              -DBUILD_CursesDialog=ON \
             -DCMAKE_CXX_STANDARD:STRING=17

make install -j${CPU_COUNT}
