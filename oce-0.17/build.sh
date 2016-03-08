mkdir build
cd build

# Configure step
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
 -DOCE_TESTING=OFF \
 -DCMAKE_PREFIX_PATH=$PREFIX \
 -DCMAKE_SYSTEM_PREFIX_PATH=$PREFIX \
 -DOCE_INSTALL_LIB_DIR=lib \
 -DOCE_INSTALL_BIN_DIR=bin \
 -DOCE_WITH_FREEIMAGE=ON \
 -DOCE_WITH_GL2PS=ON \
 -DOCE_WITH_VTK=ON \
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
