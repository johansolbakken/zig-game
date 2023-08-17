const opengl = @import("opengl.zig");
const VertexArray = @import("../../renderer/vertexarray.zig").VertexArray;
const std = @import("std");

pub fn init() !void {
    try opengl.init();
}

pub fn deinit() void {}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    opengl.setClearColor(r, g, b, a);
}

pub fn clear() void {
    opengl.clear();
}

pub fn drawIndexed(vertexArray: *VertexArray) void {
    vertexArray.bind();
    opengl.drawIndexed(opengl.DrawMode.Triangles, @intCast(vertexArray.getIndexBuffer().getCount()), opengl.GLType.UnsignedInt);
}
