declare -a CMAKE_PLATFORM_FLAGS
if [[ ${HOST} =~ .*linux.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_TOOLCHAIN_FILE="${RECIPE_DIR}/cross-linux.cmake")
fi

mkdir build
cd build

if [ `uname` != Darwin ]; then
    export LDFLAGS="-lrt -Wl,--wrap=memcpy"
fi

export LDFLAGS="$LDFLAGS -fopenmp"


# Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_PREFIX_PATH=$PREFIX \
 -DTIGL_VIEWER=OFF \
 ..


# Build step
ninja

# Install step
ninja install

# install python packages
mkdir -p $SP_DIR/tigl
touch $SP_DIR/tigl/__init__.py
cp lib/tiglwrapper.py $SP_DIR/tigl/
python $RECIPE_DIR/fixosxload.py $SP_DIR/tigl/tiglwrapper.py libTIGL

# The egg-info file is necessary because some packages
# might require tigl3 in their setup.py.
# See https://setuptools.readthedocs.io/en/latest/pkg_resources.html#workingset-objects

cat > $SP_DIR/tigl-static-$PKG_VERSION.egg-info <<FAKE_EGG
Metadata-Version: 2.1
Name: tigl-static
Version: $PKG_VERSION
Summary: The TiGL Geometry Library to process aircraft geometries in pre-design
Platform: UNKNOWN
FAKE_EGG
