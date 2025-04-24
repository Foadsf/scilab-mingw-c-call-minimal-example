// Simple test script for the wrapper DLL
function test_wrapper()
    // Path to the wrapper DLL
    wrapper_path = pwd() + filesep() + "scilab_wrapper" + getdynlibext();
    
    // Check if file exists
    if ~isfile(wrapper_path) then
        mprintf("ERROR: Wrapper DLL not found at: %s\n", wrapper_path);
        return;
    end
    
    mprintf("Wrapper DLL found at: %s\n", wrapper_path);
    
    // Try to link the wrapper DLL
    try
        lib_id = link(wrapper_path);
        mprintf("Link successful! Library ID: %d\n", lib_id);
        
        // Prepare variables
        in1 = 5.0;
        in2 = 7.0;
        out_val = 0.0;
        
        // Try to call the wrapper function
        mprintf("Calling scilab_multiply with %f * %f...\n", in1, in2);
        
        [out_val, err_code] = call("scilab_multiply", ...
                                  in1, 1, "d", ...
                                  in2, 2, "d", ...
                                  out_val, 3, "d", ...
                                  "out", [1,1], 3, "d", ...
                                  [1,1], 4, "i", ...
                                  lib_id);
        
        if err_code == 0 then
            mprintf("Function call succeeded!\n");
            mprintf("Result: %f\n", out_val);
        else
            mprintf("Function call failed with error code: %d\n", err_code);
        end
        
        // Unlink
        ulink(lib_id);
        mprintf("Unlinked successfully\n");
    catch
        mprintf("Error: %s\n", lasterror());
    end
endfunction

test_wrapper();