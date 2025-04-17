# Conda Recipes

[![Build Conda Packages](https://github.com/DLR-SC/tigl-conda/actions/workflows/build-conda-packages.yml/badge.svg)](https://github.com/DLR-SC/tigl-conda/actions/workflows/build-conda-packages.yml)

Recipies to build TiGL and its dependencies.  Use

    conda build <recipe directory>

You have to use conda >= 1.7
[conda](https://github.com/continuumio/conda).

See http://conda.pydata.org/docs/building/build.html for information on how to make a recipe.


# Build for Windows

conda build --override-channels -c dlr-sc -c dlr-sc/label/tigl3-dev -c conda-forge tigl3 --python 3.11
