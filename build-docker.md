# Build tigl3 conda package for linux using docker

## Setup docker container

Download image

    docker pull continuumio/anaconda3

Start container

    docker run -it --name anaconda -v "H:/Daniel/git/tigl-conda":/data/tigl-conda -v "H:/Daniel/git/TIGL3":/data/tigl3 continuumio/anaconda3 /bin/bash

or connect to already running container

    docker exec -it anaconda /bin/bash

Setup build env

    apt update && apt install -y build-essential cmake

## Build tigl3 library (only for debugging)

    conda env create -f /data/tigl3/environment.yml
    conda activate tigl-bld
    cd /data/tigl3/build_linux
    ./run-cmake.sh
    ./run-install.sh

## Build tigl3 package

    conda build --override-channels -c dlr-sc -c dlr-sc/label/tigl3-dev -c conda-forge /data/tigl-conda/tigl3 --python 3.11 --debug

Upload tigl3 package

    anaconda login
    anaconda upload /opt/conda/conda-bld/linux-64/tigl3*


## Snippets


cd /data/tigl-conda
mkdir /data/conda-bld





--croot /data/conda-bld




    conda config --set channel_priority flexible


cp /data/tigl-conda  /data/tigl-conda

doxygen gxx_linux-64 libx11-devel-cos6-x86_64 mesa-libgl-devel-cos6-x86_64 ninja swig xorg-x11-proto-devel-cos6-x86_64

cp /opt/conda/conda-bld/  /data/tigl-conda

    "cmake doxygen gxx_linux-64 libx11-devel-cos6-x86_64 mesa-libgl-devel-cos6-x86_64 ninja swig xorg-x11-proto-devel-cos6-x86_64
