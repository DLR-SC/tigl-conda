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
 -DBUNDLE_BUILD_GL2PS=ON ^
 -DBUNDLE_SHARED_LIBRARIES=ON ^
 -DOCE_MULTITHREAD_LIBRARY=OpenMP ^
 ..
if errorlevel 1 exit 1

REM Build step 
ninja
if errorlevel 1 exit 1

REM Install step
ninja install
if errorlevel 1 exit 1

REM Fix non-standard gl2ps include dir
move "%LIBRARY_PREFIX%"\include\gl2ps\gl2ps.h "%LIBRARY_PREFIX%"\include
rmdir /S /Q "%LIBRARY_PREFIX%"\include\gl2ps
