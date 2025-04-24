#include <stdio.h>

// No __declspec(dllexport) - Scilab might be looking specifically for non-decorated symbols
int multiply_(double *a, double *b, double *c)
{
    printf("multiply_ called with %f * %f\n", *a, *b);
    *c = (*a) * (*b);
    printf("Result: %f\n", *c);
    return 0;
}