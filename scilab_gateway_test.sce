// Test script for the Scilab gateway DLL
function test_scilab_gateway()
    // Path to the gateway DLL
    dll_path = pwd() + filesep() + "scilab_gateway" + getdynlibext();
    
    // Check if file exists
    if ~isfile(dll_path) then
        mprintf("ERROR: Gateway DLL not found at: %s\n", dll_path);
        return;
    end
    
    mprintf("Gateway DLL found at: %s\n", dll_path);
    
    // Try to link the gateway DLL with specific function names
    try
        // Link with explicit function name list
        lib_id = link(dll_path, ["multiply_doubles", "C2F(multiply_doubles)"], "c");
        mprintf("Link successful! Library ID: %d\n", lib_id);
        
        // Prepare variables
        in1 = 5.0;
        in2 = 7.0;
        out_val = 0.0;
        
        // Try both function names
        function_names = ["multiply_doubles", "C2F(multiply_doubles)"];
        
        for i = 1:size(function_names, "*")
            test_func_name = function_names(i);
            
            mprintf("\nTrying function: %s\n", test_func_name);
            
            try
                [out_val, err_code] = call(test_func_name, ...
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
        end
        
        // Unlink
        ulink(lib_id);
        mprintf("Unlinked successfully\n");
    catch
        mprintf("Link error: %s\n", lasterror());
    end
endfunction

test_scilab_gateway();