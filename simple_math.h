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

// Declare the function to be exported
DLL_EXPORT int multiply_doubles(double input1, double input2, double* output);

#endif // SIMPLE_MATH_H