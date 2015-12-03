REM remove static linking to curl etc
if %ARCH%==32 ( 
python %RECIPE_DIR%\fixpaths.py lib\tixi\tixi-targets-release.cmake C:/Jenkins/Libs/lib-static-win32/libcurl_a.lib;C:/Jenkins/Libs/lib-static-win32/libxslt_a.lib;C:/Jenkins/Libs/lib-static-win32/libxml2_a.lib;
) else (
python %RECIPE_DIR%\fixpaths.py lib\tixi\tixi-targets-release.cmake C:/Jenkins/Libs/lib-static-win64/libcurl_a.lib;C:/Jenkins/Libs/lib-static-win64/libxslt_a.lib;C:/Jenkins/Libs/lib-static-win64/libxml2_a.lib;

)

copy bin\TIXI.dll %LIBRARY_PREFIX%\bin\
copy bin\TIXI.dll %LIBRARY_PREFIX%\bin\
xcopy lib %LIBRARY_PREFIX%\lib\ /s /e
xcopy include %LIBRARY_PREFIX%\include\ /s /e

mkdir %SP_DIR%\tixi
copy share\tixi\python\tixiwrapper.py %SP_DIR%\tixi\
echo. 2> %SP_DIR%\tixi\__init__.py