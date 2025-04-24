// Scilab script to link and call the C DLL function

function run_c_example()
    ilib = -1; // Initialize library ID
    success = %f; // Flag to track success

    try
        // --- Configuration ---
        dll_name = "simple_math";
        dll_path = pwd() + filesep() + dll_name + getdynlibext();
        
        // Use the Scilab-compatible entry point with underscore suffix
        c_func_name = "multiply_doubles_"; 

        // --- Linking ---
        mprintf("Attempting to link DLL: %s\n", dll_path);
        if ~isfile(dll_path) then
            error(msprintf("DLL file not found at %s. Please run build_and_run.bat first.", dll_path));
        end

        // Link with explicit function name
        try
            mprintf("Linking with explicit function name: %s...\n", c_func_name);
            ilib = link(dll_path, [c_func_name], "c");
            mprintf("Link result: %d\n", ilib);
        catch
            error("Linking failed: " + lasterror());
        end
        
        if ilib < 0 then
            error("Failed to link DLL. Invalid library ID.");
        end
        mprintf("DLL linked successfully with ID: %d\n", ilib);

        // --- Calling the C Function ---
        mprintf("Calling C function ''%s''...\n", c_func_name);
        in1 = 7.0;
        in2 = 6.0;
        output_arg = 0.0; // Initialize output variable

        // Call using the EXACT format that worked in minimal_test.sce
        mprintf("Calling with parameters: in1=%f, in2=%f\n", in1, in2);
        
        output_arg = call(c_func_name, in1, 1, "d", in2, 2, "d", output_arg, 3, "d", "out", [1,1], 3, "d", ilib);
        
        mprintf("C function call successful.\n");
        mprintf("Value returned: %f\n", output_arg);
        success = %t;

    catch
        mprintf("\n--- SCILAB ERROR OCCURRED ---\n");
        disp(lasterror(%t));
        mprintf("-----------------------------\n");
    end

    // --- Unlinking ---
    if ilib >= 0 then
        mprintf("Attempting to unlink library ID: %d\n", ilib);
        try
            ulink(ilib);
            mprintf("Unlinked successfully.\n");
        catch
            mprintf("\n--- ERROR DURING UNLINK ---\n");
            disp(lasterror(%t));
            mprintf("---------------------------\n");
        end
    else
        mprintf("Skipping unlink because linking failed or did not occur.\n");
    end

    if success then
        mprintf("Example completed successfully.\n");
    else
        mprintf("Example encountered errors.\n");
        exit(1); // Add exit code to signal error to batch script
    end
endfunction

// Execute and clean up
run_c_example();
clear run_c_example;