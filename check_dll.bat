@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo.
echo Checking exports in simple_math.dll...
echo.

echo === Using objdump ===
objdump -p simple_math.dll | findstr -i "export"

echo.
echo === Using nm ===
nm simple_math.dll | findstr -i "multiply"

echo.
echo === Using dumpbin if available ===
where dumpbin >nul 2>&1
if %errorlevel% equ 0 (
    dumpbin /exports simple_math.dll
) else (
    echo dumpbin not found, skipping this check
)

endlocal