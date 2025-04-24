@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

:: Build the simplest possible Scilab DLL
echo Building simple Scilab DLL...
gcc -c simple_scilab.c -o simple_scilab.o
gcc -shared -o simple_scilab.dll simple_scilab.o -Wl,--output-def,simple_scilab.def -Wl,--kill-at

:: Check exports
echo Checking exports in simple_scilab.dll...
echo.
echo === Using nm ===
nm simple_scilab.dll | findstr -i "sci"

endlocal