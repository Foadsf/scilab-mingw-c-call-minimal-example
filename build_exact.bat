@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo Building exact match DLL...

:: First create a DEF file with exactly the function name as expected
echo EXPORTS > scilab_exact.def
echo multiply_doubles_ >> scilab_exact.def

:: Compile with all possible flags to match Scilab's expectations
gcc -c scilab_exact.c -o scilab_exact.o -DWIN32 -m64 -fno-leading-underscore -fPIC

:: Link with all the right options
gcc -m64 -shared -o scilab_exact.dll scilab_exact.o scilab_exact.def -Wl,--kill-at

:: Check exports and symbol names
echo Checking exports...
echo.
echo Using nm:
nm scilab_exact.dll | findstr multiply
echo.
echo Using objdump:
objdump -p scilab_exact.dll | findstr -i "export"

echo Done.
endlocal