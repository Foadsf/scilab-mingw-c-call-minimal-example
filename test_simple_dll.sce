// Test for the simplest DLL with underscore naming convention
function test_simple_dll()
    // Path to the DLL
    dll_path = pwd() + filesep() + "simple_dll" + getdynlibext();
    
    // Check if file exists
    if ~isfile(dll_path) then
        mprintf("ERROR: DLL not found at: %s\n", dll_path);
        return;
    end
    
    mprintf("DLL found at: %s\n", dll_path);
    
    // Try to link
    try
        // Link with explicit function name list
        lib_id = link(dll_path);
        mprintf("Link successful! Library ID: %d\n", lib_id);
        
        // Prepare variables
        in1 = 5.0;
        in2 = 7.0;
        out_val = 0.0;
        
        // Try different function names - with underscore is likely to work
        mprintf("\nTrying function: multiply_\n");
        
        try
            [out_val, err_code] = call("multiply_", ...
                                      in1, 1, "d", ...
                                      in2, 2, "d", ...
                                      out_val, 3, "d", ...
                                      "out", [1,1], 3, "d", ...
                                      [1,1], 4, "i", ...
                                      lib_id);
            
            if err_code == 0 then
                mprintf("Call succeeded!\n");
                mprintf("Result: %f\n", out_val);
            else
                mprintf("Call failed with error code: %d\n", err_code);
            end
        catch
            mprintf("Error calling function: %s\n", lasterror());
        end
        
        // Unlink
        ulink(lib_id);
        mprintf("Unlinked successfully\n");
    catch
        mprintf("Link error: %s\n", lasterror());
    end
endfunction

test_simple_dll();