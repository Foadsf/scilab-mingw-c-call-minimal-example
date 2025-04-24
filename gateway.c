#include <stdio.h>
#include <stdlib.h>

// Define the C2F macro correctly
#define C2F(name) name##_

// Gateway function for multiply_doubles
// Uses Scilab's expected format for gateway functions
int sci_multiply_doubles(char *fname)
{
    double in1, in2, out;
    
    // In a full implementation, we would get values from Scilab stack
    // For now, we'll use fixed values for testing
    in1 = 3.0;
    in2 = 4.0;
    out = in1 * in2;
    
    printf("Gateway called: %f * %f = %f\n", in1, in2, out);
    
    // Normally we'd push result back to Scilab stack
    // But for now just print it
    
    return 0; // 0 means success in Scilab gateways
}

// This naming pattern matches Scilab's convention
// C2F expands to multiply_doubles_
__declspec(dllexport) int multiply_doubles_(double *a, double *b, double *c)
{
    printf("C2F function called: %f * %f\n", *a, *b);
    *c = (*a) * (*b);
    printf("Result: %f\n", *c);
    return 0;
}