mkdir build
cd build

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DTIGL_VIEWER=OFF ^
 -DTIGL_PYTHON_INTERNAL=ON ^
 -DPythonOCC_SOURCE_DIR="%LIBRARY_PREFIX%"\src\pythonocc-core ^
 ..
if errorlevel 1 exit 1

REM Build step 
ninja
if errorlevel 1 exit 1

REM Install step
ninja install
if errorlevel 1 exit 1

REM install python packages
mkdir %SP_DIR%\tigl
echo. 2> %SP_DIR%\tigl\__init__.py
copy lib\tiglwrapper.py %SP_DIR%\tigl\
copy bindings\python_internal\*.py %SP_DIR%\tigl\
copy bindings\python_internal\*.pyd %SP_DIR%\tigl\
