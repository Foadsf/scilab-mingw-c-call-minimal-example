// Minimum possible Scilab-compatible DLL

// Define the C2F macro correctly
#define C2F(name) name##_

// Export with C calling convention and explicit name for Scilab
__declspec(dllexport) int __cdecl sci_test(double a, double b, double *c)
{
    // Just do a simple multiplication
    *c = a * b;
    return 0;
}

// Use the correct naming convention for Scilab
__declspec(dllexport) int __cdecl sci_test_(double *a, double *b, double *c)
{
    // Just do a simple multiplication
    *c = (*a) * (*b);
    return 0;
}