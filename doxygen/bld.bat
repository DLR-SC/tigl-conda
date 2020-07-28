mkdir build
cd build

REM Configure step
cmake -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 ..

if errorlevel 1 exit 1

REM Build step 
cmake --build . --config Release --target install
if errorlevel 1 exit 1