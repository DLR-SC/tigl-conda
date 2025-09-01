mkdir build 
cd build

REM define LIBXML_STATIC to avoid linking against libxml2.dll
set CFLAGS=/D LIBXML_STATIC
set CXXFLAGS=/D LIBXML_STATIC

cmake .. ^
 -DBUILD_SHARED_LIBS=OFF ^
 -DLIBXML_STATIC=ON ^
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

REM Remove test runners
del "%LIBRARY_PREFIX%"\bin\run*.exe /F /Q
del "%LIBRARY_PREFIX%"\bin\test*.exe /F /Q
if errorlevel 1 exit 1