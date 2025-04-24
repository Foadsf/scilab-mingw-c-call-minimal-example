// Detailed test script for diagnosing DLL linking issues

function detailed_test()
    // Setup
    dll_path = pwd() + filesep() + "simple_math" + getdynlibext();
    mprintf("Testing DLL: %s\n", dll_path);
    
    // Check file existence
    if ~isfile(dll_path) then
        mprintf("ERROR: DLL file not found!\n");
        return;
    end
    
    // Try basic linking
    try
        mprintf("Attempting to link DLL...\n");
        lib_id = link(dll_path);
        mprintf("Link successful! Library ID: %d\n", lib_id);
    catch
        mprintf("Link failed: %s\n", lasterror());
        return;
    end
    
    // Try function by ordinal number
    // This is often more reliable than using function names
    try
        mprintf("Attempting call using ordinal...\n");
        in1 = 5.0;
        in2 = 7.0;
        out_val = 0.0;
        
        // Try with ordinal 1 (first exported function)
        [out_val, err_code] = call("ordinal_1", ...
                                   in1, 1, "d", ...
                                   in2, 2, "d", ...
                                   out_val, 3, "d", ...
                                   "out", [1,1], 3, "d", ...
                                   [1,1], 4, "i", ...
                                   lib_id);
        
        if err_code == 0 then
            mprintf("SUCCESS! Ordinal call worked!\n");
            mprintf("Result: %f\n", out_val);
        else
            mprintf("Ordinal call failed with error code: %d\n", err_code);
        end
    catch
        mprintf("Ordinal call exception: %s\n", lasterror());
    end
    
    // Unlink
    try
        ulink(lib_id);
        mprintf("Unlinked successfully\n");
    catch
        mprintf("Unlink failed: %s\n", lasterror());
    end
endfunction

detailed_test();