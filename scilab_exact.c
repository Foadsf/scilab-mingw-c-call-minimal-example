#include <stdio.h>

/*
 * Based on the successful test, we now know:
 * 1. The naming convention with underscore suffix works
 * 2. Function is called correctly with parameters
 * 3. We just need to fix the return value handling
 */

/* Function with fixed return value semantics */
int multiply_doubles_(double *a, double *b, double *c)
{
    fprintf(stderr, "multiply_doubles_ called with %f * %f\n", *a, *b);
    *c = (*a) * (*b);
    fprintf(stderr, "Result: %f\n", *c);
    /* Make sure to return exactly 0 to indicate success in Scilab */
    return 0;
}