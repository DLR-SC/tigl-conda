dos2unix Source/**/*.cpp
if errorlevel 1 exit 1

patch -p1 < %RECIPE_DIR%/patches/Use-system-libs.patch
if errorlevel 1 exit 1
patch -p1 < %RECIPE_DIR%/patches/Fix-compatibility-with-system-libpng.patch
if errorlevel 1 exit 1
patch -p1 < %RECIPE_DIR%/patches/CVE-2019-12211-13.patch
if errorlevel 1 exit 1
patch -p1 < %RECIPE_DIR%/patches/freeimage-openexr3.patch
if errorlevel 1 exit 1
patch -p1 < %RECIPE_DIR%/patches/remove_auto_ptr.patch
if errorlevel 1 exit 1

rem remove all included libs to make sure these don't get used during compile
del /Q /S Source\Lib* Source\ZLib Source\OpenEXR

rem clear files which cannot be built due to dependencies on private headers
rem see also unbundle patch
echo "" > Source/FreeImage/PluginG3.cpp
echo "" > Source/FreeImageToolkit/JPEGTransform.cpp

rem copy CMake files
mkdir cmake
copy  %RECIPE_DIR%\cmake\*.cmake cmake

mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_LIBDIR=lib ^
      -DBUILD_SHARED_LIBS=OFF ^
      -DCMAKE_BUILD_TYPE=Release ^
      -G "Ninja" ^
      ..
if errorlevel 1 exit 1

ninja -v
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

rem cmake -E create_symlink ${PREFIX}/lib/libfreeimage${SHLIB_EXT} ${PREFIX}/lib/libfreeimage-${PKG_VERSION}${SHLIB_EXT}


rem msbuild.exe /p:Configuration=Release FreeImage.2017.vcxproj
rem if errorlevel 1 exit 1
rem move Dist\%PLATFORM%\FreeImage.lib %LIBRARY_LIB%\FreeImage.lib
rem move Dist\%PLATFORM%\FreeImage.dll %LIBRARY_BIN%\FreeImage.dll
rem move Dist\%PLATFORM%\FreeImage.h %LIBRARY_INC%
rem if errorlevel 1 exit 1
