EXAMPLES_BASE_PATH :: #run tprint("%examples", #filepath);

#run {
    set_build_options_dc(.{do_output = false});

    build_options_dc := get_build_options();

    build(build_options_dc);
}

#scope_file

build :: (build_options_dc: Build_Options) {
    w := compiler_create_workspace();

    example_name := extract_example_name(
        build_options_dc.compile_time_command_line
    );

    build_dir := tprint("%build/%", #filepath, example_name);

    build_options := get_build_options(w);
    copy_commonly_propagated_fields(
        build_options_dc,
        *build_options
    );
    {
        using *build_options;
        output_type = .EXECUTABLE;
        output_executable_name = example_name;
        output_path, intermediate_path = build_dir;
    }
    set_optimization(*build_options, .DEBUG);
    set_build_options(build_options, w);

    make_directory_if_it_does_not_exist(build_dir, recursive = true);
    // @TODO: make this platform specific
    copy_file(
        tprint("%macos/libglfw.3.dylib", #filepath),
        tprint("%/libglfw.3.dylib", build_dir)
    );

    add_build_file(
        tprint("%/%/main.jai", EXAMPLES_BASE_PATH, example_name),
        w
    );
}

extract_example_name :: (args: []string) -> string {
    if args.count >= 0 {
        return args[0];
    } 

    log("No example name passed, building default example 'Window'", flags = .WARNING);

    return "window";
}

#import "Compiler";
#import "Basic";
#import "File";
#import "FIle_Utilities";
