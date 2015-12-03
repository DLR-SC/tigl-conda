mkdir build
cd build

REM Remove dot from PY_VER for use in library name
set MY_PY_VER=%PY_VER:.=%

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DTIGL_VIEWER=OFF ^
 -DTIGL_PYTHON_INTERNAL=ON ^
 -DPythonOCC_SOURCE_DIR="%LIBRARY_PREFIX%"\src\pythonocc-core ^
 -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%" ^
 -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%"/include ^
 -DPYTHON_LIBRARY:FILEPATH="%PREFIX%"/libs/python%MY_PY_VER%.lib ^
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
