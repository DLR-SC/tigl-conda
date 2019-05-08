# To make libTIXI.so back-portable, we have to use clock_gettime
# from librt instead of glibc. Thus we have to link rt explicitly

mkdir build
cd build

if [ `uname` == Darwin ]; then
    EXTRA_LIBS="-lm -liconv -framework Foundation -lz -framework Security $LDFLAGS"
else
    export LDFLAGS="-lrt -Wl,--wrap=memcpy"
    EXTRA_LIBS="-lm -lrt $LDFLAGS"
fi

export CXXFLAGS="$CXXFLAGS -DGTEST_USE_OWN_TR1_TUPLE=1"

# Configure step
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
 -DCMAKE_SHARED_LINKER_FLAGS="$EXTRA_LIBS" \
 -DCMAKE_EXE_LINKER_FLAGS="$EXTRA_LIBS" \
 -DTIXI_BUILD_TESTS=ON \
 ..

# Build step
make -j $CPU_COUNT

# remove linkage to static libs
cmake .

# Install step
make install

# Tests
# make test

# create the binary package
#make package
#cp *.tar.gz $RECIPE_DIR/

# install python packages
mkdir -p $SP_DIR/tixi
touch $SP_DIR/tixi/__init__.py
cp lib/tixiwrapper.py $SP_DIR/tixi/
python $RECIPE_DIR/fixosxload.py $SP_DIR/tixi/tixiwrapper.py libTIXI
