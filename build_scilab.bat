@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

:: Build the Scilab gateway
echo Building Scilab gateway...
gcc -c gateway.c -o gateway.o
gcc -shared -o scilab_gateway.dll gateway.o -Wl,--output-def,scilab_gateway.def -Wl,--kill-at

:: Check exports
echo Checking exports in scilab_gateway.dll...
echo.
echo === Using nm ===
nm scilab_gateway.dll | findstr -i "multiply"

endlocal