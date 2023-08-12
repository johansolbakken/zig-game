const opengl = @import("opengl.zig");
const OpenGLVertexArray = @import("openglvertexarray.zig").OpenGLVertexArray;

pub fn init() !void {
    try opengl.init();
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    opengl.setClearColor(r, g, b, a);
}

pub fn clear() void {
    opengl.clear();
}

pub fn drawIndexed(vertexArray: *OpenGLVertexArray, count: u32) void {
    vertexArray.bind();
    opengl.drawIndexed(opengl.DrawMode.Triangles, @intCast(count), opengl.GLType.UnsignedInt);
}
