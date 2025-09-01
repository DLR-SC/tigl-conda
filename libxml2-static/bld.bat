mkdir build 
cd build

cmake .. ^
 -DBUILD_SHARED_LIBS=OFF ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% % ^
 -DCMAKE_C_FLAGS="/MD /O2 /fno-semantic-interposition" ^
 -DCMAKE_CXX_FLAGS="/MD /O2 /fno-semantic-interposition" ^
 -DLIBXML2_WITH_ICONV=OFF ^
 -DLIBXML2_WITH_PYTHON=OFF ^
 -DLIBXML2_WITH_ZLIB=OFF 
if errorlevel 1 exit 1

REM Build step 
cmake --build . --config Release
if errorlevel 1 exit 1

REM Install step
cmake --install . --config Release
if errorlevel 1 exit 1

REM Rename libxml2s.lib to libxml2.lib
rename "%LIBRARY_PREFIX%\lib\libxml2s.lib" "libxml2.lib"
if errorlevel 1 exit 1

REM Remove test runners
del "%LIBRARY_PREFIX%"\bin\run*.exe /F /Q
del "%LIBRARY_PREFIX%"\bin\test*.exe /F /Q
if errorlevel 1 exit 1