@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "SCILAB_CLI_EXE=C:\Program Files\scilab-2024.0.0\bin\WScilex-cli.exe"

set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo Running fixed test...
"%SCILAB_CLI_EXE%" -f exact_test_fixed.sce -quit

echo Test completed with exit code: %errorlevel%
endlocal