#include <stdio.h>
#include <windows.h>

typedef int (*multiply_doubles_func)(double, double, double*);

int main() {
    HMODULE hLib = LoadLibrary("simple_math.dll");
    
    if (!hLib) {
        printf("Failed to load DLL. Error code: %lu\n", GetLastError());
        return 1;
    }
    
    printf("DLL loaded successfully\n");
    
    multiply_doubles_func func = (multiply_doubles_func)GetProcAddress(hLib, "multiply_doubles");
    
    if (!func) {
        printf("Failed to get function address. Error code: %lu\n", GetLastError());
        // Try with underscore prefix
        func = (multiply_doubles_func)GetProcAddress(hLib, "_multiply_doubles");
        
        if (!func) {
            printf("Failed with underscore prefix too. Error code: %lu\n", GetLastError());
            FreeLibrary(hLib);
            return 1;
        }
        printf("Function found with underscore prefix\n");
    } else {
        printf("Function address obtained successfully\n");
    }
    
    double result = 0.0;
    int ret = func(5.0, 7.0, &result);
    
    printf("Function call returned: %d\n", ret);
    printf("Result: %.2f\n", result);
    
    FreeLibrary(hLib);
    printf("DLL unloaded\n");
    
    return 0;
}