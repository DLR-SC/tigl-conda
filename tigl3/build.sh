
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
 -DTIGL_VIEWER=OFF \
 -DTIGL_CONCAT_GENERATED_FILES=ON \
 -DTIGL_BINDINGS_PYTHON_INTERNAL=ON \
 -DPython3_FIND_STRATEGY=LOCATION \
 -DPython3_FIND_FRAMEWORK=NEVER \
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

# The egg-info file is necessary because some packages
# might require tigl3 in their setup.py.
# See https://setuptools.readthedocs.io/en/latest/pkg_resources.html#workingset-objects

cat > $SP_DIR/tigl3-$PKG_VERSION.egg-info <<FAKE_EGG
Metadata-Version: 2.1
Name: tigl3
Version: $PKG_VERSION
Summary: The TiGL Geometry Library to process aircraft geometries in pre-design
Platform: UNKNOWN
FAKE_EGG