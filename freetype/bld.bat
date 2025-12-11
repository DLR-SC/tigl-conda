mkdir buildd
cd buildd

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DFT_DISABLE_PNG=TRUE ^
 -DFT_DISABLE_ZLIB=TRUE ^
 -DFT_DISABLE_BZIP2=TRUE ^
 -DFT_DISABLE_HARFBUZZ=TRUE ^
 -DFT_DISABLE_BROTLI=TRUE ^
 ..
if errorlevel 1 exit 1

REM Build step 
ninja
if errorlevel 1 exit 1

REM Install step
ninja install
if errorlevel 1 exit 1

