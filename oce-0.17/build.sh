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


mkdir build
cd build

# Configure step
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
  ${CMAKE_PLATFORM_FLAGS[@]} \
 -DOCE_TESTING=OFF \
 -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
 -DOCE_INSTALL_LIB_DIR=lib \
 -DOCE_INSTALL_BIN_DIR=bin \
 -DOCE_WITH_FREEIMAGE=ON \
 -DOCE_WITH_GL2PS=ON \
 -DOCE_MULTITHREAD_LIBRARY=TBB \
 -DOCE_INSTALL_PREFIX=$PREFIX -DOCE_ENABLE_DEB_FLAG=OFF ..

# Build step
make -j $CPU_COUNT

# Install step
make install

if [ `uname` != Darwin ]; then
    python $RECIPE_DIR/remove-system-libs.py $PREFIX/lib/oce-0.17/OCE-libraries-release.cmake
else
    python $RECIPE_DIR/remove-system-libs.py $PREFIX/OCE.framework/Versions/0.17/Resources/OCE-libraries-release.cmake
fi
