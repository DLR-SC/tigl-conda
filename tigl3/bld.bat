mkdir build
cd build

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
 -DTIGL_CONCAT_GENERATED_FILES=ON ^
 -DPython3_FIND_STRATEGY=LOCATION ^
 -DPython3_FIND_REGISTRY=NEVER ^
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
REM might require tigl3 in their setup.py.
REM See https://setuptools.readthedocs.io/en/latest/pkg_resources.html#workingset-objects

set egg_info=%SP_DIR%\tigl3-%PKG_VERSION%.egg-info
echo>%egg_info% Metadata-Version: 2.1
echo>>%egg_info% Name: tigl3
echo>>%egg_info% Version: %PKG_VERSION%
echo>>%egg_info% Summary: The TiGL Geometry Library to process aircraft geometries in pre-design
echo>>%egg_info% Platform: UNKNOWN