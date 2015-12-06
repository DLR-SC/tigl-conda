# make an in source build do to some problems with install

if [ `uname` == Darwin ]; then
    PY_LIB="libpython${PY_VER}.dylib"
else
    if [ "$PY3K" == "1" ]; then
        PY_LIB="libpython${PY_VER}m.so"
    else 
        PY_LIB="libpython${PY_VER}.so"
    fi
fi

# Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_PREFIX_PATH=$PREFIX \
 -DCMAKE_SYSTEM_PREFIX_PATH=$PREFIX \
 -DPYTHON_EXECUTABLE:FILEPATH=$PYTHON \
 -DPYTHON_INCLUDE_DIR:PATH=$PREFIX/include/python$PY_VER \
 -DPYTHON_LIBRARY:FILEPATH=$PREFIX/lib/${PY_LIB} \
 .
 
# Build step 
ninja

# Install step
ninja install

# copy the source
mkdir -p $PREFIX/src
mkdir -p $PREFIX/src/pythonocc-core
cp -r src $PREFIX/src/pythonocc-core
