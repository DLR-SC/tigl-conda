mkdir build
cd build

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
 -DTIGL_VIEWER=OFF \
 -DTIGL_PYTHON_INTERNAL=ON \
 -DPythonOCC_SOURCE_DIR=$PREFIX/src/pythonocc-core \
 -DPYTHON_EXECUTABLE:FILEPATH=$PYTHON \
 -DPYTHON_INCLUDE_DIR:PATH=$PREFIX/include/python$PY_VER \
 -DPYTHON_LIBRARY:FILEPATH=$PREFIX/lib/${PY_LIB} \
 ..


# Build step
ninja

# Install step
ninja install

# install python packages
mkdir -p $SP_DIR/tigl
touch $SP_DIR/tigl/__init__.py
cp lib/tiglwrapper.py $SP_DIR/tigl/
mv $PREFIX/share/tigl/python/internal/* $SP_DIR/tigl/
python $RECIPE_DIR/fixosxload.py $SP_DIR/tigl/tiglwrapper.py libTIGL
