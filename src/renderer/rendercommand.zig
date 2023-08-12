const opengl = @import("../platform/opengl/opengl.zig");

pub fn init() !void {
    try opengl.init();
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    opengl.setClearColor(r, g, b, a);
}

pub fn clear() void {
    opengl.clear();
}
