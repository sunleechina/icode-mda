@echo off
set OLDPATH=%PATH%

rem Setup the Visual Studio Environment
rem ***Make sure this file exists (Check "Program Files (x86)" vs "Program Files")***
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"

rem Make CMake visible to the command prompt
rem ***Make sure this file exists (Check "Program Files (x86)" vs "Program Files")***
set PATH="C:\Program Files (x86)\CMake 2.8\bin";%PATH%

rem If you have Qt4 installed, you can use it to build the 
rem OSSIM gui called Imagelinker. It can be built by turning
rem on the CMake variable named "BUILD_OSSIMQT4"
rem Setup the Qt Envrionment variables for building ossimqt4

rem set QMAKESPEC=D:\libraries\qt\4.7.3\mkspecs\win32-msvc2010
rem set QTDIR=D:\libraries\qt\4.7.3
rem set PATH=D:\libraries\qt\4.7.3\bin;%PATH%

rem Point the ossim_trunk_dir and ossim_third_party_dir to the corresponding
rem locations on your machine
set ossim_trunk_dir="D:/libraries/ossim/ossim_trunk"
set ossim_third_party_dir="D:/libraries/ossim/3rd-party"
set ossim_third_party_lib=%ossim_third_party_dir%/lib/win32

rem If you like the command prompt better, you can replace the
rem -G argument below with "NMake Makefiles" instead of "Visual Studio 10"

rem This is just calling cmake with a long list of arguments
rem The "^" is inserted so that the command can continue on the next line
rem If you change these arguments make sure that your entry looks like the rest

cmake -G "Visual Studio 10"^
 -DWIN32_USE_MP=ON^
 -DBUILD_CSMAPI=OFF^
 -DBUILD_LIBRARY_DIR=lib^
 -DBUILD_OMS=OFF^
 -DBUILD_OSSIM=ON^
 -DBUILD_OSSIMGUI=OFF^
 -DBUILD_OSSIM_PLUGIN=ON^
 -DBUILD_OSSIMCONTRIB_PLUGIN=OFF^
 -DBUILD_OSSIMCSM_PLUGIN=OFF^
 -DBUILD_OSSIMGDAL_PLUGIN=ON^
 -DBUILD_OSSIMKAKADU_PLUGIN=OFF^
 -DBUILD_OSSIMLIBRAW_PLUGIN=OFF^
 -DBUILD_OSSIMMRSID_PLUGIN=OFF^
 -DBUILD_OSSIMNDF_PLUGIN=OFF^
 -DBUILD_OSSIMNUI_PLUGIN=OFF^
 -DBUILD_OSSIMPNG_PLUGIN=OFF^
 -DBUILD_OSSIMREGISTRATION_PLUGIN=OFF^
 -DBUILD_OSSIMQT4=OFF^
 -DBUILD_OSSIM_MPI_SUPPORT=0^
 -DBUILD_OSSIMPLANET=OFF^
 -DBUILD_OSSIMPLANETQT=OFF^
 -DBUILD_OSSIMPREDATOR=OFF^
 -DBUILD_OSSIM_TEST_APPS=1^
 -DBUILD_RUNTIME_DIR=bin^
 -DBUILD_SHARED_LIBS=ON^
 -DBUILD_WMS=OFF^
 -DCMAKE_BUILD_TYPE=Release^
 -DCMAKE_INCLUDE_PATH=%ossim_third_party_dir%/include^
 -DCMAKE_INSTALL_PREFIX=%ossim_third_party_dir%/local^
 -DCMAKE_LIBRARY_PATH=%ossim_third_party_dir%/lib^
 -DCMAKE_CXX_FLAGS_RELEASE="/MD /O2 /Ob2 /MP /D NDEBUG"^
 -DCMAKE_MODULE_PATH=%ossim_trunk_dir%/cmake/CMakeModules^
 -DOSSIM_PLUGINS_INCLUDE_DIR=%ossim_trunk_dir%/ossim_plugins^
 -DOSSIM_COMPILE_WITH_FULL_WARNING=ON^
 -DOSSIM_DEPENDENCIES=%ossim_third_party_dir%^
 -DOSSIM_DEV_HOME=%ossim_trunk_dir%^
 -DBUILD_SHARED_LIBS=ON^
 -DOPENTHREADS_LIBRARY=%ossim_third_party_lib%/OpenThreadsWin32.lib^
 -DPNG_LIBRARY=%ossim_third_party_lib%/libpng.lib^
 -DTIFF_LIBRARY=%ossim_third_party_lib%/libtiff_i.lib^
 -DGEOTIFF_LIBRARY=%ossim_third_party_lib%/geotiff_i.lib^
 -DFFTW3_LIBRARY=%ossim_third_party_lib%/libfftw3-3.lib^
 -DMRSID_LIBRARY=%ossim_third_party_lib%/lti_dsdk_dll.lib^
 -DMRSID_INCLUDE_DIR=%ossim_third_party_dir%/mrsid/Geo_DSDK-7.0.0.2181.win32-vc9/Geo_DSDK-7.0.0.2181/include^
 -DGDAL_LIBRARY=%ossim_third_party_lib%/gdal_i.lib^
 -DGDAL_INCLUDE_DIR=%ossim_third_party_dir%/include/gdal^
 -DGEOTIFF_INCLUDE_DIR=%ossim_third_party_dir%/include/geotiff^
 -DJPEG_INCLUDE_DIR=%ossim_third_party_dir%/include/jpeg8a^
 -DJPEG_LIBRARY=%ossim_third_party_lib%/libjpeg.lib^
 -DOPENTHREADS_INCLUDE_DIR=%ossim_third_party_dir%/include^
 -DTIFF_INCLUDE_DIR=%ossim_third_party_dir%/include/tiff^
 -DZLIB_INCLUDE_DIR=%ossim_third_party_dir%/zlib^
 -DZLIB_LIBRARY=%ossim_third_party_lib%/zlib.lib^
 -DGEOS_LIBRARY=%ossim_third_party_lib%/geos.lib^
 -DGEOS_INCLUDE_DIR=%ossim_third_party_dir%/include/geos^
 -DMINIZIP_INCLUDE_DIR=%ossim_third_party_dir%/include/minizip^
 -DMINIZIP_LIBRARY=%ossim_third_party_lib%/minizip.lib;%ossim_third_party_lib%/zlib1.lib;^
 %ossim_trunk_dir%/ossim_package_support/cmake/

set PATH=%OLDPATH%
set OLDPATH=
