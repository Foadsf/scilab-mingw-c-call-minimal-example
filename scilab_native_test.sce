// Test using Scilab's native support for creating C files
function test_scilab_native()
    // First, create a C file using Scilab
    c_code = [
        "#include <stdio.h>",
        "",
        "int multiply_doubles_(double *a, double *b, double *c)",
        "{",
        "    fprintf(stderr, ""C function called: %f * %f\\n"", *a, *b);",
        "    *c = (*a) * (*b);",
        "    fprintf(stderr, ""Result: %f\\n"", *c);",
        "    return 0;",
        "}"
    ];
    
    // Write the C code to a file
    mputl(c_code, "scilab_native.c");
    mprintf("Created C file: scilab_native.c\n");
    
    // Now use Scilab's built-in ilib_for_link to compile and link
    mprintf("Compiling using Scilab''s built-in tools...\n");
    
    try
        // Get current directory
        cur_dir = pwd();
        
        // Build the library
        ilib_for_link("multiply_doubles", "scilab_native.c", [], "c");
        
        // The filename depends on platform
        if getos() == "Windows" then
            lib_name = "libmultiply_doubles" + getdynlibext();
        else
            lib_name = "libmultiply_doubles" + getdynlibext();
        end
        
        // Check if library was created
        if ~isfile(lib_name) then
            mprintf("ERROR: Library file not created at: %s\n", lib_name);
            return;
        end
        
        mprintf("Library created at: %s\n", lib_name);
        
        // Now link to the library
        lib_id = link(lib_name);
        mprintf("Link successful, ID: %d\n", lib_id);
        
        // Prepare variables
        a = 8.0;
        b = 9.0;
        c = 0.0;
        
        mprintf("Calling function with %f * %f\n", a, b);
        
        // Try to call the function
        [c, err] = call("multiply_doubles_", ...
                       a, 1, "d", ...
                       b, 2, "d", ...
                       c, 3, "d", ...
                       "out", [1,1], 3, "d", ...
                       [1,1], 4, "i", ...
                       lib_id);
        
        if err == 0 then
            mprintf("Call successful! Result: %f\n", c);
        else
            mprintf("Call returned error: %d\n", err);
        end
        
        // Cleanup
        ulink(lib_id);
        mprintf("Unlinked successfully\n");
    catch
        mprintf("Error: %s\n", lasterror());
    end
endfunction

// Run the test
test_scilab_native();