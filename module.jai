Window :: struct {}

Monitor :: struct {}

Hint_Name :: enum_flags {
    CONTEXT_VERSION_MAJOR: : 0x00022002;
    CONTEXT_VERSION_MINOR: : 0x00022003;
    OPENGL_PROFILE:        : 0x00022008;
    OPENGL_FORWARD_COMPAT: : 0x00022006;
}

Hint_Value :: enum_flags {
    OPENGL_CORE_PROFILE: : 0x00032001;
    TRUE:                : 1;
}

Framebuffer_Size_Proc :: #type (
    window: *Window,
    width:  s32,
    height: s32
) #c_call;

Key :: enum u16 {
    ESCAPE :: 256;
}

Key_Action :: enum {
    RELEASE: : 0;
    PRESS:   : 1;
    REPEAT:  : 2;
}

init :: () -> s32 #foreign glfw "glfwInit";

terminate :: () -> s32 #foreign glfw "glfwTerminate";

window_hint :: (
    hint:  Hint_Name,
    value: Hint_Value
) #foreign glfw "glfwWindowHint";

create_window :: (
    width:   u32,
    height:  u32,
    title:   string,
    monitor: *Monitor = null,
    share:   *Window  = null
) -> *Window {
    c_title := to_c_string(title);
    defer free(c_title);

    return glfwCreateWindow(
        cast(s32) width,
        cast(s32) height,
        c_title,
        monitor,
        share,
    );
}

destroy_window :: (window: *Window) #foreign glfw "glfwDestroyWindow";

make_context_current :: (
    window: *Window
) #foreign glfw "glfwMakeContextCurrent";

window_should_close :: (
    window: *Window
) -> s32 #foreign glfw "glfwWindowShouldClose";

swap_buffers  :: (window: *Window) #foreign glfw "glfwSwapBuffers";

poll_events  :: () #foreign glfw "glfwPollEvents";

get_frame_buffer_size :: (
    window: *Window,
    width:  *s32,
    height: *s32
) #foreign "glfwGetFramebufferSize";

set_framebuffer_size_callback :: (
    window:   *Window,
    callback: Framebuffer_Size_Proc
) #foreign glfw "glfwSetFramebufferSizeCallback";

get_key :: (window: *Window, key: Key) -> Key_Action #foreign glfw "glfwGetKey";

set_window_should_close :: (
    window: *Window,
    value: int
) #foreign "glfwSetWindowShouldClose";

get_proc_address :: (
    proc_name: *u8
) -> *void #foreign glfw "glfwGetProcAddress";

#scope_file;

#import "Basic";

#if OS == .MACOS {
    glfw :: #library "macos/libglfw.3";
}

glfwCreateWindow :: (
    width: s32,
    height: s32,
    title: *u8,
    monitor: *Monitor,
    share: *Window
) -> *Window #foreign glfw;
