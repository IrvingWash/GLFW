GLFW :: #import "GLFW";
#import "Basic";
#import "GL";

main :: () {
    ok := GLFW.init();
    if !ok {
        log_error("Failed to initialize GLFW");
        return;
    }
    defer GLFW.terminate();

    GLFW.window_hint(.CONTEXT_VERSION_MAJOR, 3);
    GLFW.window_hint(.CONTEXT_VERSION_MINOR, 3);
    GLFW.window_hint(.OPENGL_PROFILE, .OPENGL_CORE_PROFILE);

    window := GLFW.create_window(800, 600, "Test");
    if !window {
        log_error("Failed to create GLFW window");
        return;
    }
    defer GLFW.destroy_window(window);

    GLFW.make_context_current(window);

    while !GLFW.window_should_close(window) {
        glClearColor(1, 1, 1, 1);
        glClear(GL_COLOR_BUFFER_BIT);

        width, height: s32;
        GLFW.get_frame_buffer_size(window, *width, *height);
        glViewport(0, 0, xx width, xx height);

        GLFW.swap_buffers(window);

        GLFW.poll_events();
    }
}
