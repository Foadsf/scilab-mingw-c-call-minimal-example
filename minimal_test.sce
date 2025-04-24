// Very minimal test with careful parameter counting
function test_exact_minimal()
    dll_path = pwd() + filesep() + "scilab_exact" + getdynlibext();
    
    if ~isfile(dll_path) then
        mprintf("DLL not found\n");
        return;
    end
    
    mprintf("DLL found\n");
    
    // Link with explicit function name
    lib_id = link(dll_path, ["multiply_doubles_"], "c");
    mprintf("Link ID: %d\n", lib_id);
    
    // Start with simple values
    a = 5.0;
    b = 7.0;
    c = 0.0;
    
    mprintf("Calling function...\n");
    
    // The most basic call format according to documentation
    try
        c = call("multiply_doubles_", a, 1, "d", b, 2, "d", c, 3, "d", "out", [1,1], 3, "d", lib_id);
        mprintf("Result: %f\n", c);
    catch
        mprintf("Error: %s\n", lasterror());
    end
    
    // Clean up
    ulink(lib_id);
    mprintf("Done\n");
endfunction

test_exact_minimal();