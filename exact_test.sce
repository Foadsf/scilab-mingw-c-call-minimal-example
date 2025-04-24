// Final attempt with exact parameter matching
function test_exact()
    // Get DLL path
    dll_path = pwd() + filesep() + "scilab_exact" + getdynlibext();
    
    // Check if file exists
    if ~isfile(dll_path) then
        error("DLL file not found at: " + dll_path);
    end
    
    mprintf("DLL found at: %s\n", dll_path);
    
    // Link the DLL with explicit function name
    try
        lib_id = link(dll_path, ["multiply_doubles_"], "c");
        mprintf("Link successful, ID: %d\n", lib_id);
    catch
        mprintf("Error linking: %s\n", lasterror());
        return;
    end
    
    // Prepare variables - passed exactly as doubles
    a = 5.0;
    b = 7.0;
    c = 0.0;
    
    mprintf("Calling multiply_doubles_ with %f * %f\n", a, b);
    
    // Try call with exactly matching Scilab's pattern
    try
        // First parameter is function name
        // For each input parameter: value, position, type ("d" for double)
        // For output parameter: value, position, type
        // "out" indicates which parameter is output, followed by dimensions and position
        // Return value info: dimensions, position, type
        // Library ID at end
        [c, err] = call("multiply_doubles_", ...
                        a, 1, "d", ...  // First input: double
                        b, 2, "d", ...  // Second input: double
                        c, 3, "d", ...  // Input/output: double pointer
                        "out", [1,1], 3, "d", ... // Output spec: scalar double at position 3
                        [1,1], 4, "i", ... // Return value is scalar integer
                        lib_id);
        
        if err == 0 then
            mprintf("Call successful! Result: %f\n", c);
        else
            mprintf("Call returned error: %d\n", err);
        end
    catch
        mprintf("Error calling function: %s\n", lasterror());
    end
    
    // Clean up
    ulink(lib_id);
    mprintf("Unlinked successfully\n");
endfunction

// Execute the test with error handling
try
    test_exact();
catch
    mprintf("Test error: %s\n", lasterror());
end