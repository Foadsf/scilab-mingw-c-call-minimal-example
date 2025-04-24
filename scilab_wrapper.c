#include <stdio.h>
#include "simple_math.h"

// Simple wrapper function that explicitly follows Scilab's calling convention
// Note: Scilab likely expects specific calling conventions
__declspec(dllexport) int scilab_multiply(double in1, double in2, double* out)
{
    printf("Scilab wrapper called with: %f * %f\n", in1, in2);
    int result = multiply_doubles(in1, in2, out);
    printf("Result calculated: %f\n", *out);
    return result;
}