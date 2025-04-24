// Simplified test script with very precise call pattern
function test_adapter()
    // Get DLL path
    dll_path = pwd() + filesep() + "scilab_adapter" + getdynlibext();
    
    // Check if file exists
    if ~isfile(dll_path) then
        error("DLL file not found at: " + dll_path);
    end
    
    mprintf("DLL found at: %s\n", dll_path);
    
    // Link the DLL using the simplest form
    lib_id = link(dll_path);
    mprintf("Link successful, ID: %d\n", lib_id);
    
    // Prepare variables
    a = 6.0;
    b = 7.0;
    c = 0.0;
    
    // Try direct call with the exact Fortran-style name
    mprintf("Calling multiply_ function with arguments: %f, %f\n", a, b);
    
    // Use the most basic call syntax with raw types
    [c, err] = call("multiply_", a, 1, "d", b, 2, "d", c, 3, "d", "out", [1,1], 3, "d", [1,1], 4, "i", lib_id);
    
    if err == 0 then
        mprintf("Call successful! Result: %f\n", c);
    else
        mprintf("Call returned error: %d\n", err);
    end
    
    // Clean up
    ulink(lib_id);
    mprintf("Unlinked successfully\n");
endfunction

// Execute the test
try
    test_adapter();
catch
    mprintf("Error in test: %s\n", lasterror());
end