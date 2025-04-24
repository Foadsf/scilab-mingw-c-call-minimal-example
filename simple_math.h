#ifndef SIMPLE_MATH_H
#define SIMPLE_MATH_H

// Define DLL_EXPORT for Windows DLL export/import
#ifdef _WIN32
  #ifdef BUILDING_DLL // Defined when compiling the DLL itself
    #define DLL_EXPORT __declspec(dllexport)
  #else // Defined when linking against the DLL
    #define DLL_EXPORT __declspec(dllimport)
  #endif
#else // Non-Windows platforms
  #define DLL_EXPORT
#endif

// Ensure C linkage even if included from C++
#ifdef __cplusplus
extern "C" {
#endif

// Original function (for regular C usage)
DLL_EXPORT int multiply_doubles(double input1, double input2, double* output);

// Scilab-compatible function with underscore suffix
DLL_EXPORT int multiply_doubles_(double *input1, double *input2, double* output);

#ifdef __cplusplus
} // End extern "C"
#endif

#endif // SIMPLE_MATH_H