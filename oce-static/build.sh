#! /bin/bash

declare -a CMAKE_PLATFORM_FLAGS
if [[ ${HOST} =~ .*linux.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi


if [ `uname` == Darwin ]; then
    # the vtk config files use some system specific libs which we have to remove
    #python $RECIPE_DIR/remove-system-libs.py $PREFIX/lib/cmake/vtk-6.3/VTKTargets.cmake
    echo "MAC"
fi


mkdir -p build
cd build

# Configure step
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -G "Ninja" \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_CXX_FLAGS=-fPIC \
 -DCMAKE_C_FLAGS=-fPIC \
  ${CMAKE_PLATFORM_FLAGS[@]} \
 -DOCE_TESTING=OFF \
 -DOCE_BUILD_SHARED_LIB=OFF \
 -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
 -DOCE_INSTALL_LIB_DIR=lib \
 -DOCE_INSTALL_BIN_DIR=bin \
 -DOCE_WITH_FREEIMAGE=ON \
 -DOCE_MULTITHREAD_LIBRARY=OPENMP \
 -DOCE_INSTALL_PREFIX=$PREFIX -DOCE_ENABLE_DEB_FLAG=OFF ..

# Build step
cmake --build . 

# Install step
cmake --build .  --target install

