#include <stdio.h>
#include <windows.h>

typedef int (*multiply_func)(double, double, double*);

int main() {
    HMODULE dll = LoadLibrary("simple_math.dll");
    if (!dll) {
        printf("Failed to load DLL: %lu\n", GetLastError());
        return 1;
    }
    
    printf("DLL loaded successfully\n");
    
    // Try all possible function name variations
    const char* func_names[] = {
        "multiply_doubles",
        "_multiply_doubles",
        "multiply_doubles@12",
        "_multiply_doubles@12"
    };
    
    multiply_func func = NULL;
    for (int i = 0; i < 4; i++) {
        func = (multiply_func)GetProcAddress(dll, func_names[i]);
        if (func) {
            printf("Found function with name: %s\n", func_names[i]);
            break;
        }
    }
    
    if (!func) {
        printf("Failed to find any function variation\n");
        FreeLibrary(dll);
        return 1;
    }
    
    double result = 0.0;
    int ret = func(3.5, 2.0, &result);
    
    printf("Function call returned: %d\n", ret);
    printf("Result: %.2f\n", result);
    
    FreeLibrary(dll);
    printf("Test completed successfully\n");
    
    return 0;
}