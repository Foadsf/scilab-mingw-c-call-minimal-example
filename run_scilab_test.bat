@echo off
setlocal

set "MINGW_BIN_PATH=C:\msys64\mingw64\bin"
set "SCILAB_CLI_EXE=C:\Program Files\scilab-2024.0.0\bin\WScilex-cli.exe"

set "PATH=%MINGW_BIN_PATH%;%PATH%"

echo Running Scilab wrapper test...
"%SCILAB_CLI_EXE%" -f scilab_test.sce -quit

echo Scilab test completed with exit code: %errorlevel%
endlocal