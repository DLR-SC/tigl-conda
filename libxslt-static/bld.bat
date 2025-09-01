mkdir build 
cd build

cmake .. ^
 -DBUILD_SHARED_LIBS=OFF ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% % ^
 -DCMAKE_C_FLAGS="/MD /O2 /fno-semantic-interposition" ^
 -DCMAKE_CXX_FLAGS="/MD /O2 /fno-semantic-interposition" ^
 -DLIBXSLT_WITH_CRYPTO=OFF ^
 -DLIBXSLT_WITH_PYTHON=OFF ^
 -DLIBXSLT_WITH_TESTS=OFF
if errorlevel 1 exit 1


REM Build step 
cmake --build . --config Release
if errorlevel 1 exit 1

REM Install step
cmake --install . --config Release
if errorlevel 1 exit 1

REM Remove test runners
move "%LIBRARY_PREFIX%"\lib\lib*xslt.dll "%LIBRARY_PREFIX%"\bin\
if errorlevel 1 exit 1