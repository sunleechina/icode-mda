@echo off

set OLDPATH=%PATH%

call "C:\Program Files\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"

set PATH="C:\Program Files\CMake 2.8\bin";%PATH%


set common_dir="C:\development\3rd-party"
set common_lib=%common_dir%/lib/win32
set ossim_install_dir="C:\development\ossim_trunk"
set ossim_lib_dir="C:\development\rapier\Release"
set gdalDir="C:\development\gdal-1.9.0"
set boostDir="C:\development\boost_1_49_0\boost_1_49_0"
rem set OPENCV_LIBRARIES=%common_lib%/cv210.lib;%common_lib%/cvaux210.lib;%common_lib%/cxcore210.lib;%common_lib%/cxts210.lib;%common_lib%/ml210.lib;%common_lib%/highgui210.lib

cmake -G "Visual Studio 10"^
 -DTHIRD_PARTY_INCLUDE_DIR=%common_dir%/include;%gdalDir%/include^
 -DTHIRD_PARTY_LIBRARIES=%OPENCV_LIBRARIES%;%gdalDir%/lib/gdal_i.lib^
 -DOSSIM_INCLUDE_DIR=%ossim_install_dir%/ossim/include;%ossim_install_dir%/ossim_plugins/gdal^
 -DOSSIM_LIBRARIES=%ossim_lib_dir%/ossim.lib^
 -DBOOST_GEOMETRY_LIBRARY=%boostDir%^
 .

set PATH=%OLDPATH%
set OLDPATH=
