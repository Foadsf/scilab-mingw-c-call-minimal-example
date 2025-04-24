// Final test with simplified call format
function test_exact_simple()
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
    
    // Try simplified call format
    try
        // Use just the essential parameters
        [c, err] = call("multiply_doubles_", a, 1, "d", b, 2, "d", c, 3, "d", "out", [1,1], 3, "d", lib_id);
        
        // Just check for any error
        if err_code == 0 then
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
    test_exact_simple();
catch
    mprintf("Test error: %s\n", lasterror());
end