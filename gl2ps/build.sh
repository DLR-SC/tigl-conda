#! /bin/bash
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DENABLE_PNG=OFF .
make lib -j $CPU_COUNT
make install