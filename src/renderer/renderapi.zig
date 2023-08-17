const OpenGLRenderApi = @import("../platform/opengl/openglrenderapi.zig");
const VulkanRenderApi = @import("../platform/vulkan/vulkanrenderapi.zig");
const VertexArray = @import("vertexarray.zig").VertexArray;

pub const Api = enum {
    None,
    OpenGL,
    Vulkan,
};

pub const api = Api.OpenGL;

pub fn init() !void {
    switch (api) {
        Api.OpenGL => try OpenGLRenderApi.init(),
        Api.Vulkan => try VulkanRenderApi.init(),
        else => error.UnsupportedApi,
    }
}

pub fn deinit() void {
    switch (api) {
        Api.OpenGL => OpenGLRenderApi.deinit(),
        Api.Vulkan => VulkanRenderApi.deinit(),
        else => error.UnsupportedApi,
    }
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    switch (api) {
        Api.OpenGL => OpenGLRenderApi.setClearColor(r, g, b, a),
        else => error.UnsupportedApi,
    }
}

pub fn clear() void {
    switch (api) {
        Api.OpenGL => OpenGLRenderApi.clear(),
        else => error.UnsupportedApi,
    }
}

pub fn drawIndexed(vertexArray: *VertexArray) void {
    switch (api) {
        Api.OpenGL => OpenGLRenderApi.drawIndexed(vertexArray),
        else => error.UnsupportedApi,
    }
}
