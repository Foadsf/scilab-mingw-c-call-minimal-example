#include "simple_math.h"
#include <stdio.h> // Optional: for printf debugging if needed

// Define the exported function
// BUILDING_DLL must be defined during DLL compilation
DLL_EXPORT int multiply_doubles(double input1, double input2, double* output) {
    if (output == NULL) {
        return -1; // Error: output pointer is null
    }
    *output = input1 * input2;
    // printf("C Function: %.2f * %.2f = %.2f\n", input1, input2, *output); // Optional debug
    return 0; // Success
}