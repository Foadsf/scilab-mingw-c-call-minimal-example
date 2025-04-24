// Script to test the fully integrated simple_math DLL from Scilab
function test_simple_math()
    // Get path to the DLL
    dll_path = pwd() + filesep() + "simple_math" + getdynlibext();
    
    // Check if DLL exists
    if ~isfile(dll_path) then
        mprintf("ERROR: DLL not found at: %s\n", dll_path);
        mprintf("Please run build_and_run.bat first to create the DLL.\n");
        return;
    end
    
    mprintf("Found DLL at: %s\n", dll_path);
    
    // Link the DLL with Scilab
    try
        // Link to the DLL specifying we'll use the multiply_doubles_ function
        lib_id = link(dll_path, ["multiply_doubles_"], "c");
        mprintf("DLL linked successfully with ID: %d\n", lib_id);
    catch
        mprintf("Error linking DLL: %s\n", lasterror());
        return;
    end
    
    // Prepare test values
    a = 6.0;
    b = 7.0;
    result = 0.0;
    
    mprintf("Calling multiply_doubles_ with %f * %f\n", a, b);
    
    // Call the C function from Scilab
    try
        [result, err_code] = call("multiply_doubles_", ...
                                 a, 1, "d", ...          // First input value
                                 b, 2, "d", ...          // Second input value
                                 result, 3, "d", ...     // Result placeholder
                                 "out", [1,1], 3, "d", ... // Specify output parameter
                                 [1,1], 4, "i", ...     // Return value
                                 lib_id);
        
        // Check if call was successful
        if err_code == 0 || err_code == 10 then  // Code 10 is acceptable in Scilab
            mprintf("C function call successful!\n");
            mprintf("Result: %f\n", result);
        else
            mprintf("C function call failed with error code: %d\n", err_code);
        end
    catch
        mprintf("Error calling function: %s\n", lasterror());
    end
    
    // Unlink the DLL when done
    try
        ulink(lib_id);
        mprintf("DLL unlinked successfully.\n");
    catch
        mprintf("Error unlinking DLL: %s\n", lasterror());
    end
endfunction

// Run the test
test_simple_math();