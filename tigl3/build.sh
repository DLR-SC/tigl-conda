mkdir build
cd build

# Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX=$PREFIX \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_PREFIX_PATH=$PREFIX \
 -DCMAKE_SYSTEM_PREFIX_PATH=$PREFIX \
 -DTIGL_VIEWER=OFF \
 -DTIGL_OCE_COONS_PATCHED=ON \
 -DTIGL_CONCAT_GENERATED_FILES=ON \
 -DTIGL_BINDINGS_PYTHON_INTERNAL=ON \
 -DPythonOCC_SOURCE_DIR=$PREFIX/src/pythonocc-core \
 ..


# Build step
ninja

# Install step
ninja install

# install python packages
mkdir -p $SP_DIR/tigl3
touch $SP_DIR/tigl3/__init__.py
cp lib/tigl3wrapper.py $SP_DIR/tigl3/
mv $PREFIX/share/tigl3/python/internal/* $SP_DIR/tigl3/
python $RECIPE_DIR/fixosxload.py $SP_DIR/tigl3/tigl3wrapper.py libtigl3
