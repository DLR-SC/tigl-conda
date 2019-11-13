mkdir build
cd build

REM We need to build with bigobj support, else compilation fails for stepbasic
set CXXFLAGS=/wd4244 /bigobj

REM Configure step
cmake -G "Ninja" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DCMAKE_SYSTEM_PREFIX_PATH="%LIBRARY_PREFIX%" ^
 -DPython3_FIND_STRATEGY=LOCATION ^
 -DSWIG_HIDE_WARNINGS=ON ^
 ..
if errorlevel 1 exit 1
 
REM Build step 
ninja
if errorlevel 1 exit 1

REM Install step
ninja install
if errorlevel 1 exit 1

REM copy the source
cd ..
xcopy src "%LIBRARY_PREFIX%\src\pythonocc-core\src" /s /e /i
if errorlevel 1 exit 1