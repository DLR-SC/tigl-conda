mkdir build
cd build

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DOCE_WIN_BUNDLE_INSTALL_DIR="%LIBRARY_PREFIX%" ^
 -DOCE_WITH_FREEIMAGE=ON ^
 -DOCE_OCAF=OFF ^
 -DOCE_VISUALISATION=OFF ^
 -DOCE_WITH_GL2PS=OFF ^
 -DOCE_BUILD_SHARED_LIB=OFF ^
 -DOCE_MULTITHREAD_LIBRARY=OpenMP ^
 ..
if errorlevel 1 exit 1

REM Build step 
ninja
if errorlevel 1 exit 1

REM Install step
ninja install
if errorlevel 1 exit 1

REM fix non-standard include location
copy "%LIBRARY_PREFIX%"\include\FreeImage\FreeImage.h "%LIBRARY_PREFIX%"\include
copy "%LIBRARY_PREFIX%"\include\FreeImage\FreeImagePlus.h "%LIBRARY_PREFIX%"\include
rmdir /S /Q "%LIBRARY_PREFIX%"\include\FreeImage

