#include <stdio.h>

int multiply_doubles_(double *a, double *b, double *c)
{
    fprintf(stderr, "C function called: %f * %f\\n", *a, *b);
    *c = (*a) * (*b);
    fprintf(stderr, "Result: %f\\n", *c);
    return 0;
}
