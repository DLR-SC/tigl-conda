
declare -a CMAKE_PLATFORM_FLAGS
if [[ ${HOST} =~ .*linux.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi


mkdir -p build
cd build

# Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_PREFIX_PATH=$PREFIX \
 -DTIGL_VIEWER=ON \
 -DTIGL_CONCAT_GENERATED_FILES=OFF \
 -DTIGL_BINDINGS_PYTHON_INTERNAL=ON \
 -DPythonOCC_SOURCE_DIR=$PREFIX/src/pythonocc-core \
 ..


# Build step
ninja

# Install step
ninja install

# install python packages
mkdir -p $SP_DIR/tigl3
mv $PREFIX/share/tigl3/python/tigl3/* $SP_DIR/tigl3/
python $RECIPE_DIR/fixosxload.py $SP_DIR/tigl3/tigl3wrapper.py libtigl3
