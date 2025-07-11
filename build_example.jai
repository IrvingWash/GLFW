EXAMPLES_BASE_PATH :: #run tprint("%examples", #filepath);

#run {
    print("%\n", EXAMPLES_BASE_PATH);
    set_build_options_dc(.{do_output = false});

    build_options_dc := get_build_options();

    example_name := extract_example_name(build_options_dc.compile_time_command_line);

    build_dir := tprint("%build/%", #filepath, example_name);
    print("%\n", build_dir);

    make_directory_if_it_does_not_exist(build_dir, recursive = true);
}

#scope_file

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
