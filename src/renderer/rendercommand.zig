const RenderApi = @import("renderapi.zig");
const VertexArray = @import("vertexarray.zig").VertexArray;

pub fn init() !void {
    try RenderApi.init();
}

pub fn deinit() void {
    RenderApi.deinit();
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    RenderApi.setClearColor(r, g, b, a);
}

pub fn clear() void {
    RenderApi.clear();
}

pub fn drawIndexed(va: *VertexArray) void {
    RenderApi.drawIndexed(va);
}
