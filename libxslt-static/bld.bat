cd win32

REM define LIBXML_STATIC to avoid linking against libxml2.dll
set CFLAGS=/D LIBXML_STATIC
set CXXFLAGS=/D LIBXML_STATIC

cscript configure.js iconv=no prefix="%LIBRARY_PREFIX%" lib="%LIBRARY_PREFIX%"\lib include="%LIBRARY_PREFIX%"\include\libxml2
if errorlevel 1 exit 1

REM Build step 
nmake
if errorlevel 1 exit 1

REM Install step
nmake install
if errorlevel 1 exit 1

REM Remove test runners
move "%LIBRARY_PREFIX%"\lib\lib*xslt.dll "%LIBRARY_PREFIX%"\bin\
if errorlevel 1 exit 1