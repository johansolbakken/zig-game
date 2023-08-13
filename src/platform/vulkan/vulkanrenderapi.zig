const std = @import("std");
const builtin = @import("builtin");
const VertexArray = @import("../../renderer/VertexArray.zig").VertexArray;
const vulkan = @import("vulkan.zig");

// vulkan

const VulkanContext = struct {
    const Self = @This();

    const libraryName = switch (builtin.os.tag) {
        .macos => "libvulkan.1.dylib",
        else => unreachable,
    };

    handle: std.DynLib,
    vkGetInstanceProcAddr: vulkan.PFN_vkGetInstanceProcAddr,

    fn init() !Self {
        var library = try std.DynLib.open(libraryName);
        const vkGetInstanceProcAddr = library.lookup(vulkan.PFN_vkGetInstanceProcAddr, "vkGetInstanceProcAddr") orelse {
            return error.FailedToLoadVkGetInstanceProcAddr;
        };

        return .{
            .handle = library,
            .vkGetInstanceProcAddr = vkGetInstanceProcAddr,
        };
    }

    fn deinit(self: *Self) void {
        self.handle.close();
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
