@echo off

set OLDPATH=%PATH%

call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat"

set PATH=C:\Program Files (x86)\CMake 2.8\bin;%PATH%

set boost_dir="C:\libraries\boost_1_48_0"
set parser_src_dir="C:\Code\VMSParser\src"

cmake -G "Visual Studio 10"^
 -DPARSER_SRC_DIR=%parser_src_dir%^
 -DBOOST_INCLUDE_DIR=%boost_dir%^
 -DBOOST_LIBRARY_PATH=%boost_dir%/stage/lib^
 ../src/

set PATH=%OLDPATH%
set OLDPATH=


pause
