const opengl = @import("../platform/opengl/opengl.zig");

const Api = enum {
    OpenGL,
    Vulkan,
};

const api = Api.OpenGL;

pub fn init() !void {
    switch (api) {
        Api.OpenGL => try opengl.init(),
        else => error.UnsupportedApi,
    }
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    switch (api) {
        Api.OpenGL => opengl.setClearColor(r, g, b, a),
        else => error.UnsupportedApi,
    }
}

pub fn clear() void {
    switch (api) {
        Api.OpenGL => opengl.clear(),
        else => error.UnsupportedApi,
    }
}
