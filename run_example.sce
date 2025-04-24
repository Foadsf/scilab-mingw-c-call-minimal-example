// Scilab script to link and call the C DLL function

function run_c_example()
    ilib = -1; // Initialize library ID
    try
        // --- Configuration ---
        dll_name = "simple_math"; // Base name of the DLL (without lib prefix or .dll)
        dll_path = pwd() + filesep() + dll_name + getdynlibext(); // Full path to DLL
        c_func_name = "multiply_doubles"; // Exact name of the function in C
        scilab_routine_name = "c_multiply"; // How we want to refer to it in Scilab (optional, can be same as c_func_name)

        // --- Linking ---
        mprintf("Attempting to link DLL: %s\n", dll_path);
        if ~isfile(dll_path) then
            error(msprintf("DLL not found at %s. Run build_and_run.bat first.", dll_path));
        end

        // Link the DLL. The second argument (routine name) is optional here,
        // but specifying it can help if there are conflicts.
        // The loader function (third arg) is not needed for simple C DLLs.
        ilib = link(dll_path, scilab_routine_name);
        if ilib <= 0 then
             error(msprintf("Failed to link DLL %s.", dll_path));
        end
        mprintf("DLL linked successfully with ID: %d\n", ilib);

        // --- Calling the C Function ---
        mprintf("Calling C function ''%s''...\n", c_func_name);
        in1 = 7.0;  // Input 1 (double)
        in2 = 6.0;  // Input 2 (double)
        output_arg = 0.0; // Placeholder for output (must be passed)

        // call(c_func_name, arg1, type1, ..., argN, typeN, num_outputs, out_type1, ..., out_typeM, external_name)
        // 'd' = double, 'i' = integer, 'c' = char, 'h' = short, 'f' = float, 'l' = long? (check docs)
        // Need to specify output type even if passed by pointer
        [err_code, result_out] = call(c_func_name,       .. // Name of function in C
                                     in1, 'd',           .. // Arg 1, type 'd'
                                     in2, 'd',           .. // Arg 2, type 'd'
                                     output_arg, 'd',    .. // Arg 3 (output pointer), treat as double input for call
                                     1, 'd',             .. // Number of outputs (1), type of output ('d')
                                     scilab_routine_name);  // Name used in link()

        if err_code <> 0 then
             error(msprintf("Error code %d returned from calling C function ''%s''.", err_code, c_func_name));
        end

        mprintf("C function returned: %f\n", result_out);
        // Note: 'call' returns the value *directly*, not via the pointer arg for this setup.

    catch
        disp(lasterror());
    finally
        // --- Unlinking ---
        if ilib > 0 then
            mprintf("Unlinking library ID: %d\n", ilib);
            try
                ulink(ilib);
                mprintf("Unlinked successfully.\n");
            catch
                disp("Error during unlink:");
                disp(lasterror());
            end
        end
    end
endfunction

run_c_example();
clear run_c_example; // Clean up