// Scilab script to link and call the C DLL function

function run_c_example()
    ilib = -1; // Initialize library ID
    success = %f; // Flag to track success
    err_code = -999; // Initialize error code variable

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

        mprintf("Calling with parameters: in1=%f, in2=%f\n", in1, in2);

        // === MODIFIED CALL START ===
        // Explicitly capture the C function's integer return value
        // The C function takes 3 args (pointers), so the return value is conceptually at position 4
        [output_arg, err_code] = call(c_func_name, ...
                                      in1, 1, "d", ...          // Arg 1 (input double*)
                                      in2, 2, "d", ...          // Arg 2 (input double*)
                                      output_arg, 3, "d", ...   // Arg 3 (output double*)
                                      "out", [1,1], 3, "d", ... // Output Spec: output_arg gets value from C arg 3 (scalar double)
                                      [1,1], 4, "i", ...        // Return Spec: err_code gets value from C return (scalar int)
                                      ilib);                     // Library ID
        // === MODIFIED CALL END ===

        // Check the error code returned by the C function (and potentially by call itself)
        // C function returns 0 on success. Scilab's call might return others.
        if err_code == 0 then
             mprintf("C function call successful (returned 0).\n");
             mprintf("Value returned by C function (via output parameter): %f\n", output_arg);
             success = %t;
        else
            // Include output_arg here as it might hold a value even if err_code is non-zero
            mprintf("C function call returned error code: %d\n", err_code);
            mprintf("Value in output_arg (might be uninitialized or partial): %f\n", output_arg);
            // Consider raising an error or just marking as failed
             // error(msprintf("C function call failed with error code: %d", err_code));
        end

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
        // Ensure the batch script knows about the failure
        if exists("err_code") && err_code <> 0 then
             exit(err_code); // Exit with C error code if available and non-zero
        else
             exit(1); // Generic error exit code
        end
    end
endfunction

// Execute and clean up
run_c_example();
clear run_c_example;
clear err_code; // Clear the added variable