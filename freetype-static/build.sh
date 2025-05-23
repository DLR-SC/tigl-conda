mkdir buildd
cd buildd

# Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_PREFIX_PATH=$PREFIX \
 -DCMAKE_SYSTEM_PREFIX_PATH=$PREFIX \
 -DWITH_PNG=OFF \
 -DWITH_ZLIB=OFF \
 -DWITH_BZip2=OFF \
 -DWITH_HarfBuzz=OFF \
 ..

# Build step 
ninja

# Install step
ninja install

