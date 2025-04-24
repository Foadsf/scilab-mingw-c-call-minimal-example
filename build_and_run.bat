@echo off
setlocal enabledelayedexpansion

:: --- Configuration: adjust these if needed ---
set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "SCILAB_CLI_EXE=C:\Program Files\scilab-2024.0.0\bin\WScilex-cli.exe"
:: --- End Configuration ---

:: 1) Add MinGW to PATH
set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo.
echo === Environment Check ===
echo PATH = %PATH%
echo.

:: 2) Verify gcc is on PATH
echo Checking for gcc...
where gcc >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: gcc not found in PATH. Make sure "%MINGW_BIN_PATH%\gcc.exe" exists.
    goto error
)
echo found: 
where gcc
echo.

:: 3) Verify Scilab CLI exists
echo Checking for Scilab CLI...
if not exist "%SCILAB_CLI_EXE%" (
    echo.
    echo ERROR: Scilab CLI not found at "%SCILAB_CLI_EXE%".
    goto error
)
echo found: "%SCILAB_CLI_EXE%"
echo.

:: 4) Show current directory for debugging
echo Current directory: %CD%
echo.

:: 5) Generate list of include paths from gcc
echo Getting gcc system include paths...
gcc -v -xc -E - < NUL 2>&1 | findstr "^ " > gcc_paths.txt
type gcc_paths.txt
echo.

:: 6) Clean previous artifacts
echo Cleaning previous artifacts...
del simple_math.o simple_math.dll >nul 2>&1
echo.

:: 7) Compile the C code with verbose output
echo Compiling simple_math.c to object file...
gcc -v -c simple_math.c -o simple_math.o -DBUILDING_DLL -Wall
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to compile simple_math.c
    goto error
)
echo OK.
echo.

:: 8) Link into DLL with debug and verbose output - now including Scilab compatibility
echo Creating simple_math.dll...
gcc -v -shared -o simple_math.dll simple_math.o -Wl,--output-def,simple_math.def -Wl,--out-implib,libsimple_math.a -Wl,--export-all-symbols -Wl,--kill-at
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to create simple_math.dll
    goto error
)
echo OK.
echo.

:: 9) Show DLL exports for debugging
echo DLL exports:
dumpbin /exports simple_math.dll 2>nul || objdump -p simple_math.dll | findstr -i "export"
echo.

:: 10) Run the Scilab script
echo DLL build successful.
echo.
echo === Running Scilab example ===
echo.
"%SCILAB_CLI_EXE%" -f run_example.sce -quit

:: Check for Scilab errors properly
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Scilab script failed with exit code %errorlevel%.
    goto error
)
echo.
echo Scilab script finished successfully.
echo.

endlocal
echo Script completed successfully.
goto eof

:error
echo.
echo Script failed.
endlocal
exit /b 1

:eof
exit /b 0