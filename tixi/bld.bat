mkdir build
cd build

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 ..
if errorlevel 1 exit 1

REM Build step 
ninja
if errorlevel 1 exit 1

REM Install step
ninja install
if errorlevel 1 exit 1

REM install python packages
mkdir %SP_DIR%\tixi
echo. 2> %SP_DIR%\tixi\__init__.py
copy lib\tixiwrapper.py %SP_DIR%\tixi\

REM remove static linking to curl etc
python %RECIPE_DIR%\fixpaths.py %LIBRARY_PREFIX%\lib\tixi\tixi-targets-release.cmake %LIBRARY_PREFIX%/lib/libcurl_a.lib;
python %RECIPE_DIR%\fixpaths.py %LIBRARY_PREFIX%\lib\tixi\tixi-targets-release.cmake %LIBRARY_PREFIX%/lib/libxslt_a.lib;
python %RECIPE_DIR%\fixpaths.py %LIBRARY_PREFIX%\lib\tixi\tixi-targets-release.cmake %LIBRARY_PREFIX%/lib/libxml2_a.lib;

