// Simple DLL test script for debugging
function debug_dll()
    // Get DLL path
    dll_path = pwd() + filesep() + "simple_math" + getdynlibext();
    mprintf("DLL path: %s\n", dll_path);
    
    // Check if file exists
    if ~isfile(dll_path) then
        mprintf("ERROR: DLL file does not exist!\n");
        return;
    end
    
    mprintf("DLL file exists, attempting to link...\n");
    
    // Try linking
    try
        lib_id = link(dll_path);
        mprintf("Link successful! Library ID: %d\n", lib_id);
        
        // Try to get function info
        try
            // Try a simpler approach than libraryinfo
            result = call("_multiply_doubles", 3.0, 1, "d", 4.0, 2, "d", 0.0, 3, "d", "out", [1,1], 3, "d", [1,1], 4, "i", lib_id);
            mprintf("Test call result: %f\n", result);
        catch
            mprintf("Error testing function: %s\n", lasterror());
        end
        
        // Unlink when done
        ulink(lib_id);
        mprintf("Unlinked successfully.\n");
    catch
        mprintf("Link failed: %s\n", lasterror());
    end
endfunction

debug_dll();
clear debug_dll;