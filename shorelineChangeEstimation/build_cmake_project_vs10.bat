@echo off

set OLDPATH=%PATH%

call "C:\Program Files\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"

set PATH="C:\Program Files\CMake 2.8\bin";%PATH%


set common_dir="C:/development/3rd-party"
set common_lib=%common_dir%/lib/win32
set ossim_install_dir="C:/development/ossim_trunk"
set ossim_lib_dir="C:/development/ossim_build/Release"
set boostDir="C:/development/boost_1_49_0/boost_1_49_0/"

cmake -G "Visual Studio 10"^
 -DOSSIM_INCLUDE_DIR=%ossim_install_dir%/ossim/include;%ossim_install_dir%/ossim_plugins/gdal^
 -DBOOST_GEOMETRY_LIBRARY=%boostDir%^
 -DOSSIM_LIBRARIES=%ossim_lib_dir%/ossim.lib^
 -DTHIRD_PARTY_INCLUDE_DIR=%common_dir%/include;%gdalDir%/include^
 -DTHIRD_PARTY_LIBRARIES=%common_lib%/gdal_i.lib^
  .

set PATH=%OLDPATH%
set OLDPATH=
