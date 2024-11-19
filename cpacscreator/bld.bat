copy %RECIPE_DIR%\boost-patch\* thirdparty\

mkdir build
cd build

REM Remove dot from PY_VER for use in library name
set MY_PY_VER=%PY_VER:.=%

REM We need own flags as conda turns on program size optimization
REM which ends up in huge static library sizes
set CFLAGS=
set CXXFLAGS=

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DTIGL_VIEWER=ON ^
 -DTIGL_BINDINGS_PYTHON_INTERNAL=ON ^
 -DPythonOCC_SOURCE_DIR="%LIBRARY_PREFIX%"\src\pythonocc-core ^
 -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%" ^
 -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%"/include ^
 -DTIGL_CONCAT_GENERATED_FILES=OFF ^
 -DPYTHON_LIBRARY:FILEPATH="%PREFIX%"/libs/python%MY_PY_VER%.lib ^
 ..
if errorlevel 1 exit 1

REM Build step 
cmake --build . --config Release
if errorlevel 1 exit 1

REM Install step
cmake --build . --target install --config Release
if errorlevel 1 exit 1

REM install python packages
move %LIBRARY_PREFIX%\share\tigl3\python\tigl3 %SP_DIR%

REM The egg-info file is necessary because some packages,
REM might require cpacscreator in their setup.py.
REM See https://setuptools.readthedocs.io/en/latest/pkg_resources.html#workingset-objects

set egg_info=%SP_DIR%\cpacscreator-%PKG_VERSION%.egg-info
echo>%egg_info% Metadata-Version: 2.1
echo>>%egg_info% Name: tigl3
echo>>%egg_info% Version: %PKG_VERSION%
echo>>%egg_info% Summary: The TiGL Geometry Library to process aircraft geometries in pre-design
echo>>%egg_info% Platform: UNKNOWN