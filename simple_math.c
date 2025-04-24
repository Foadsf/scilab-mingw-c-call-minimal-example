#include "simple_math.h"
#include <stdio.h> // For printf debugging

// Define the original exported function
// BUILDING_DLL must be defined during DLL compilation
DLL_EXPORT int multiply_doubles(double input1, double input2, double* output) {
    if (output == NULL) {
        return -1; // Error: output pointer is null
    }
    
    // Add debugging to verify function is called
    printf("C Function called: %.2f * %.2f\n", input1, input2);
    
    *output = input1 * input2;
    
    printf("C Function result: %.2f\n", *output);
    return 0; // Success
}

// Add a Scilab-compatible function with underscore suffix
DLL_EXPORT int multiply_doubles_(double *input1, double *input2, double* output) {
    if (output == NULL) {
        return -1; // Error: output pointer is null
    }
    
    // Add debugging to verify function is called
    printf("Scilab function called: %.2f * %.2f\n", *input1, *input2);
    
    *output = (*input1) * (*input2);
    
    printf("Scilab function result: %.2f\n", *output);
    return 0; // Success
}