@echo off
setlocal

set "SCILAB_CLI_EXE=C:\Program Files\scilab-2024.0.0\bin\WScilex-cli.exe"

echo Extracting Scilab DLL information...
"%SCILAB_CLI_EXE%" -f extract_scilab_methods.sce -quit > scilab_info.txt

echo Information saved to scilab_info.txt
type scilab_info.txt
endlocal