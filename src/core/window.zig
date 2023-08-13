const glfw3 = @import("../platform/glfw/glfw3.zig");
const Input = @import("input.zig");
const RenderApi = @import("../renderer/renderapi.zig");

pub const Window = struct {
    const Self = @This();

    title: []const u8,
    width: u32,
    height: u32,
    handle: *glfw3.GLFWwindow,

    pub fn init(title: []const u8, width: u32, height: u32) !Self {
        if (glfw3.glfwInit() == 0) {
            return error.GlfwInitFailed;
        }

        switch (RenderApi.api) {
            .OpenGL => {
                glfw3.glfwWindowHint(glfw3.GLFW_CONTEXT_VERSION_MAJOR, 4);
                glfw3.glfwWindowHint(glfw3.GLFW_CONTEXT_VERSION_MINOR, 1);
                glfw3.glfwWindowHint(glfw3.GLFW_OPENGL_PROFILE, glfw3.GLFW_OPENGL_CORE_PROFILE);
                glfw3.glfwWindowHint(glfw3.GLFW_OPENGL_FORWARD_COMPAT, 1);
            },
            .Vulkan => {
                glfw3.glfwWindowHint(glfw3.GLFW_CLIENT_API, glfw3.GLFW_NO_API);
            },
            else => return error.UnsupportedRenderApi,
        }

        const window = glfw3.glfwCreateWindow(640, 480, @ptrCast(title), null, null);
        if (window == null) {
            return error.GlfwWindowCreationFailed;
        }

        glfw3.glfwMakeContextCurrent(window.?);

        _ = glfw3.glfwSetKeyCallback(window, &handleKeyCallback);

        return Self{
            .title = title,
            .width = width,
            .height = height,
            .handle = window.?,
        };
    }

    pub fn deinit(self: *Self) void {
        glfw3.glfwDestroyWindow(self.handle);
        glfw3.glfwTerminate();
    }

    pub fn shouldClose(self: *Self) bool {
        return glfw3.glfwWindowShouldClose(self.handle) != 0;
    }

    pub fn update(self: *Self) void {
        glfw3.glfwSwapBuffers(self.handle);
        glfw3.glfwPollEvents();
    }

    fn handleKeyCallback(window: ?*glfw3.GLFWwindow, key: c_int, scancode: c_int, action: c_int, mods: c_int) callconv(.C) void {
        _ = window;
        _ = mods;
        _ = scancode;

        switch (action) {
            glfw3.GLFW_PRESS => Input.setKeyPressed(@enumFromInt(key), true),
            glfw3.GLFW_RELEASE => Input.setKeyPressed(@enumFromInt(key), false),
            glfw3.GLFW_REPEAT => {},
            else => {},
        }
    }
};
