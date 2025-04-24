@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

:: First build the regular DLL as before
echo Building main library...
gcc -c simple_math.c -o simple_math.o -DBUILDING_DLL
gcc -shared -o simple_math.dll simple_math.o -Wl,--output-def,simple_math.def -Wl,--out-implib,libsimple_math.a

:: Now build the Scilab wrapper
echo Building Scilab wrapper...
gcc -c scilab_wrapper.c -o scilab_wrapper.o
gcc -shared -o scilab_wrapper.dll scilab_wrapper.o -L. -lsimple_math -Wl,--output-def,scilab_wrapper.def -Wl,--kill-at

echo Checking exports in scilab_wrapper.dll...
echo.
echo === Using nm ===
nm scilab_wrapper.dll | findstr -i "scilab"

endlocal