// Test script for calling DLL function by ordinal number instead of name
function test_ordinal()
    dll_path = pwd() + filesep() + "simple_math" + getdynlibext();
    mprintf("Testing DLL: %s\n", dll_path);
    
    if ~isfile(dll_path) then
        mprintf("ERROR: DLL file not found!\n");
        return;
    end
    
    try
        lib_id = link(dll_path);
        mprintf("Link successful! Library ID: %d\n", lib_id);
        
        // Call by name but with special syntax
        in1 = 5.0;
        in2 = 7.0;
        out_val = 0.0;
        
        // Try with a completely different approach using execstr
        try
            mprintf("Trying with execstr...\n");
            
            // This approach can sometimes work when the normal call() method fails
            cmd = "result = call(""multiply_doubles"", " + ...
                  string(in1) + ", 1, ""d"", " + ...
                  string(in2) + ", 2, ""d"", " + ...
                  "0.0, 3, ""d"", " + ...
                  """out"", [1,1], 3, ""d"", " + ...
                  "[1,1], 4, ""i"", " + ...
                  string(lib_id) + ")";
            
            mprintf("Executing: %s\n", cmd);
            execstr(cmd);
            mprintf("Result: %s\n", string(result));
        catch
            mprintf("execstr approach failed: %s\n", lasterror());
        end
        
        // Unlink
        ulink(lib_id);
        mprintf("Unlinked successfully\n");
    catch
        mprintf("Link failed: %s\n", lasterror());
    end
endfunction

test_ordinal();