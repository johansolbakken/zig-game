const opengl = @import("opengl.zig");
const OpenGLVertexArray = @import("openglvertexarray.zig").OpenGLVertexArray;
const std = @import("std");

pub fn init() !void {
    try opengl.init();
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    opengl.setClearColor(r, g, b, a);
}

pub fn clear() void {
    opengl.clear();
}

pub fn drawIndexed(vertexArray: *OpenGLVertexArray) void {
    vertexArray.bind();
    // getCount = 0
    opengl.drawIndexed(opengl.DrawMode.Triangles, @intCast(vertexArray.indexBuffer.getCount()), opengl.GLType.UnsignedInt);
}
