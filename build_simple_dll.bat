@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo Building simple DLL...
gcc -c simple_dll.c -o simple_dll.o
gcc -shared -o simple_dll.dll simple_dll.o -Wl,--output-def,simple_dll.def -Wl,--kill-at

echo Checking exports...
nm simple_dll.dll | findstr multiply

echo Creating test program...
gcc -o test_simple_dll.exe test_dll.c
echo Running test program...
test_simple_dll.exe

endlocal