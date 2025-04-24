@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo Building adapter DLL...

REM First, create an explicit DEF file that exports the function name exactly
echo EXPORTS > adapter.def
echo multiply_ >> adapter.def

REM Compile without any special decorations
gcc -c scilab_adapter.c -o scilab_adapter.o -fno-leading-underscore

REM Link with the explicit DEF file to ensure the exported name is exactly "multiply_" 
gcc -shared -o scilab_adapter.dll scilab_adapter.o adapter.def -Wl,--kill-at

echo Checking exports...
nm scilab_adapter.dll | findstr multiply

echo Done.
endlocal