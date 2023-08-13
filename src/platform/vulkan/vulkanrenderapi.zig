const std = @import("std");
const VertexArray = @import("../../renderer/VertexArray.zig").VertexArray;
const vulkan = @import("vulkan.zig");

// vulkan

const VulkanContext = struct {
    const Self = @This();

    fn init() !Self {
        return .{};
    }

    fn deinit(self: *Self) void {
        _ = self;
    }
};

var vulkanContext: VulkanContext = undefined;

pub fn init() !void {
    vulkanContext = try VulkanContext.init();
}

pub fn deinit() void {
    vulkanContext.deinit();
    vulkanContext = undefined;
}

pub fn setClearColor(r: f32, g: f32, b: f32, a: f32) void {
    _ = a;
    _ = b;
    _ = g;
    _ = r;
    //opengl.setClearColor(r, g, b, a);
}

pub fn clear() void {
    //opengl.clear();
}

pub fn drawIndexed(vertexArray: *VertexArray) void {
    vertexArray.bind();
    // getCount = 0
    //opengl.drawIndexed(opengl.DrawMode.Triangles, @intCast(vertexArray.indexBuffer.getCount()), opengl.GLType.UnsignedInt);
}
