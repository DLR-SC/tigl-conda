mkdir buildd
cd buildd

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DOCE_WIN_BUNDLE_INSTALL_DIR="%LIBRARY_PREFIX%" ^
 -DBUNDLE_BUILD_FREEIMAGE=OFF ^
 -DBUNDLE_BUILD_FREETYPE=OFF ^
 -DBUNDLE_BUILD_GL2PS=OFF ^
 -DBUNDLE_SHARED_LIBRARIES=ON ^
 -DOCE_MULTITHREAD_LIBRARY=TBB ^
 -DTBB_BUILD_SHARED=ON ^
 -DTBB_BUILD_STATIC=OFF ^
 ..
if errorlevel 1 exit 1

REM Build step 
ninja
if errorlevel 1 exit 1

REM Install step
ninja install
if errorlevel 1 exit 1

