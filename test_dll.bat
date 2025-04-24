@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo Compiling test_dll.c...
gcc test_dll.c -o test_dll.exe

if %errorlevel% neq 0 (
    echo Failed to compile test_dll.c
    exit /b 1
)

echo Running test_dll.exe...
test_dll.exe

echo Test completed with exit code: %errorlevel%
endlocal