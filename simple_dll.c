#include <stdio.h>

// Export a simple function with underscore suffix (common in Scilab)
__declspec(dllexport) int multiply_(double *a, double *b, double *c)
{
    printf("multiply_ function called with %f * %f\n", *a, *b);
    *c = (*a) * (*b);
    printf("Result: %f\n", *c);
    return 0;
}