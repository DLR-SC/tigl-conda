mkdir build 
cd build

cmake .. ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% % ^
 -DLIBXSLT_WITH_CRYPTO=OFF ^
 -DLIBXSLT_WITH_PYTHON=OFF ^
 -DLIBXSLT_WITH_TESTS=OFF ^
 -DLIBXSLT_WITH_PROGRAMS=OFF ^
 -DLIBXSLT_WITH_PROFILER=OFF
if errorlevel 1 exit 1

REM Build step 
cmake --build . --config Release --verbose
if errorlevel 1 exit 1

REM Install step
cmake --install . --config Release --component Development
cmake --install . --config Release --component Runtime
if errorlevel 1 exit 1