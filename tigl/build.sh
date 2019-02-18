declare -a CMAKE_PLATFORM_FLAGS
if [[ ${HOST} =~ .*linux.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi

mkdir build
cd build

if [ `uname` != Darwin ]; then
    export LDFLAGS="-lrt -Wl,--wrap=memcpy"
fi


# Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_PREFIX_PATH=$PREFIX \
 -DTIGL_VIEWER=OFF \
 -DTIGL_BINDINGS_PYTHON_INTERNAL=ON \
 -DPythonOCC_SOURCE_DIR=$PREFIX/src/pythonocc-core \
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
