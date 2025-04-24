@echo off
set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo Compiling simple_test.c...
gcc simple_test.c -o simple_test.exe

if %errorlevel% neq 0 (
    echo Failed to compile simple_test.c
    exit /b 1
)

echo Running simple_test.exe...
simple_test.exe

echo Test completed with exit code: %errorlevel%