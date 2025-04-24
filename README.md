# Scilab MinGW C Call Minimal Example

A minimal example showing how to compile a C DLL using the MinGW-w64 GCC compiler and call its function from Scilab on Windows using the `link` and `call` functions.

This demonstrates the most direct way to integrate simple C functions without involving the full Scilab toolbox build system or C++ gateways.

## Purpose

This repository serves as a concise reference for:
*   Compiling a C function into a Windows DLL using GCC (via MinGW-w64).
*   Loading that DLL into Scilab using `link()`.
*   Calling an exported function from the DLL within Scilab using `call()`.
*   Passing arguments (doubles) and receiving a result (double) between Scilab and C.

## Files

*   `simple_math.h`: Header file for the C library, declaring the exported function.
*   `simple_math.c`: Source file implementing the simple C `multiply_doubles` function.
*   `build_and_run.bat`: Windows batch script to compile the C code into `simple_math.dll` and then run the Scilab example script.
*   `run_example.sce`: Scilab script that links the `simple_math.dll` and calls the `multiply_doubles` function using `call()`.
*   `README.md`: This file.
*   `.gitignore`: Excludes build artifacts.

## Prerequisites

*   **Windows Operating System**
*   **Scilab:** Installed (e.g., via winget, choco, or official installer). Tested with Scilab 2024.0.0.
*   **MinGW-w64:** Installed (typically via MSYS2). The GCC compiler (`gcc.exe`) must be accessible.
*   **PATH Configuration:** Ensure the `bin` directory of your MinGW-w64 installation (e.g., `C:\msys64\mingw64\bin`) is added to your Windows system `PATH` environment variable, OR modify the `MINGW_BIN_PATH` variable at the top of `build_and_run.bat`.
*   **Scilab Path:** Modify the `SCILAB_CLI_EXE` variable at the top of `build_and_run.bat` if your Scilab installation path is different.

## How to Run

1.  **Clone** this repository.
2.  **Open a Command Prompt (`cmd.exe`)** in the repository's root directory.
3.  **Verify/Edit Paths:** Check the `MINGW_BIN_PATH` and `SCILAB_CLI_EXE` variables at the top of `build_and_run.bat` and adjust them if necessary to match your system setup.
4.  **Execute the batch script:**
    ```cmd
    .\build_and_run.bat
    ```

## Expected Output

The batch script will first compile the C code. If successful, it will launch Scilab, which will then execute `run_example.sce`. You should see output similar to this in your command prompt:

```
Cleaning previous artifacts...
Compiling simple_math.c to object file...
Creating simple_math.dll...
DLL build successful.
---
Running Scilab script...
 Scilab 2024.0.0 (Oct 24 2023, 15:08:37)
Attempting to link DLL: C:\path\to\your\repo\simple_math.dll
DLL linked successfully with ID: <some_number>
Calling C function 'multiply_doubles'...
C function returned: 42.000000
Unlinking library ID: <some_number>
Unlinked successfully.
---
Scilab script finished.
```

## License

This repository and its contents are provided under the [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## Author

Foad S. Farimani (f.s.farimani@gmail.com)
Based on concepts explored during debugging of Scilab toolbox builds referencing Spoken Tutorials by IIT Bombay.
