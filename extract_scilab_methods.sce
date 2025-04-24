// Script to extract information about how Scilab handles DLL linking
function extract_scilab_info()
    mprintf("=== Scilab DLL Handling Information ===\n\n");
    
    // 1. Get information about the link function
    mprintf("link() function details:\n");
    help link
    mprintf("\n");
    
    // 2. Get information about the call function
    mprintf("call() function details:\n");
    help call
    mprintf("\n");
    
    // 3. Get linked libraries information
    mprintf("Currently linked libraries:\n");
    try
        libs = libraryinfo();
        disp(libs);
    catch
        mprintf("Error getting library info: %s\n", lasterror());
    end
    mprintf("\n");
    
    // 4. Try to find sample DLLs that come with Scilab
    scilab_home = SCI;
    mprintf("Scilab installation directory: %s\n", scilab_home);
    
    // Look for DLLs in bin directory
    bin_dir = scilab_home + "/bin";
    mprintf("Checking for DLLs in: %s\n", bin_dir);
    
    try
        files = ls(bin_dir + "/*.dll");
        mprintf("Found %d DLL files\n", size(files, "*"));
        
        // List a few examples
        if size(files, "*") > 0 then
            mprintf("Sample DLLs:\n");
            for i = 1:min(5, size(files, "*"))
                mprintf("  %s\n", files(i));
            end
        end
    catch
        mprintf("Error listing DLLs: %s\n", lasterror());
    end
    
    mprintf("\n=== End of Scilab DLL Information ===\n");
endfunction

extract_scilab_info();