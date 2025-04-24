# Scilab MinGW C Call Minimal Example

A minimal example showing how to compile a C DLL using the MinGW-w64 GCC compiler and call its function from Scilab on Windows using the `link` and `call` functions.

This demonstrates the most direct way to integrate simple C functions without involving the full Scilab toolbox build system or C++ gateways.

## Purpose

This repository serves as a concise reference for:
*   Compiling a C function into a Windows DLL using GCC (via MinGW-w64).
*   Loading that DLL into Scilab using `link()`.
*   Calling an exported function from the DLL within Scilab using `call()`.
*   Passing arguments (doubles) and receiving a result (double) between Scilab and C.

## Key Insights

After extensive testing, we discovered these critical requirements for Scilab DLL integration:

1. **Fortran-style Function Names**: Scilab expects function names with underscore suffixes (e.g., `multiply_doubles_`).
2. **By-Reference Parameters**: Functions should accept parameters as pointers (e.g., `double*`) rather than values.
3. **Proper Exports**: The `--kill-at` linker flag helps ensure function names are exported without decorations.
4. **Compatible Call Syntax**: Use the simplified Scilab `call()` function format for reliable integration.

## Files

*   `simple_math.h`: Header file for the C library, declaring the exported functions.
*   `simple_math.c`: Source file implementing both the standard C `multiply_doubles` function and the Scilab-compatible `multiply_doubles_` function.
*   `build_and_run.bat`: Windows batch script to compile the C code into `simple_math.dll` and then run the Scilab example script.
*   `run_example.sce`: Scilab script that links the `simple_math.dll` and calls the `multiply_doubles_` function using `call()`.
*   `test_dll.c` and `test_dll.bat`: C program and batch script to test the DLL from regular C code.
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
Linking with explicit function name: multiply_doubles_...
Link result: 0
DLL linked successfully with ID: 0
Calling C function 'multiply_doubles_'...
Calling with parameters: in1=7.000000, in2=6.000000
Scilab function called: 7.00 * 6.00
Scilab function result: 42.00
C function call successful.
Value returned: 42.000000
Attempting to unlink library ID: 0
Unlinked successfully.
Example completed successfully.
---
Scilab script finished successfully.
```

## DLL Function Implementation Details

To make a C function callable from Scilab, implement two versions:

1. Standard C version (for regular C programs):
```c
DLL_EXPORT int multiply_doubles(double input1, double input2, double* output) {
    *output = input1 * input2;
    return 0; // Success
}
```

2. Scilab-compatible version (with underscore suffix and by-reference parameters):
```c
DLL_EXPORT int multiply_doubles_(double *input1, double *input2, double* output) {
    *output = (*input1) * (*input2);
    return 0; // Success
}
```

## Calling from Scilab

Use this pattern to call the DLL function from Scilab:

```scilab
// Link the DLL with explicit function name
ilib = link(dll_path, ["multiply_doubles_"], "c");

// Call the function
result = call("multiply_doubles_", 
             value1, 1, "d",           // Input 1: double
             value2, 2, "d",           // Input 2: double
             initial_result, 3, "d",   // Input/Output: double
             "out", [1,1], 3, "d",     // Output is at position 3, a 1x1 double
             ilib);                    // Library ID

// Unlink when done
ulink(ilib);
```

## Troubleshooting

If you encounter issues:

1. **Check DLL Exports**: Use `nm simple_math.dll | findstr multiply` to verify function exports.
2. **Verify Function Names**: Ensure Scilab-compatible functions have underscore suffixes.
3. **Linking Issues**: Explicitly specify function names in the `link()` call.
4. **Call Parameter Format**: Follow the exact format shown above for the `call()` function.

## License

This repository and its contents are provided under the [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## Author

Foad S. Farimani (f.s.farimani@gmail.com)  
Based on concepts explored during debugging of Scilab toolbox builds referencing Spoken Tutorials by IIT Bombay.