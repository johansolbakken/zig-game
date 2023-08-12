const OpenGLRenderApi = @import("../platform/opengl/openglrenderapi.zig");
const VertexArray = @import("vertexarray.zig").VertexArray;

pub const Api = enum {
    OpenGL,
    Vulkan,
};

pub const api = Api.OpenGL;

pub fn init() !void {
    switch (api) {
        Api.OpenGL => try OpenGLRenderApi.init(),
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

pub fn drawIndexed(vertexArray: *VertexArray, count: u32) void {
    switch (api) {
        Api.OpenGL => OpenGLRenderApi.drawIndexed(&vertexArray.glImpl, count),
        else => error.UnsupportedApi,
    }
}
