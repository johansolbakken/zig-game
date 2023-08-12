const std = @import("std");
const glfw3 = @import("glfw3.zig");

pub fn main() !void {
    if (glfw3.glfwInit() == 0) {
        std.log.warn("glfwInit() failed\n", .{});
        return;
    }
    defer glfw3.glfwTerminate();

    const window = glfw3.glfwCreateWindow(640, 480, "Hello World", null, null);
    if (window == null) {
        std.log.warn("glfwCreateWindow() failed\n", .{});
        return;
    }
    defer glfw3.glfwDestroyWindow(window);

    glfw3.glfwMakeContextCurrent(window);

    while (glfw3.glfwWindowShouldClose(window) == 0) {
        glfw3.glfwSwapBuffers(window);
        glfw3.glfwPollEvents();
    }
}
