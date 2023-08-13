const std = @import("std");
const builtin = @import("builtin");
const VertexArray = @import("../../renderer/VertexArray.zig").VertexArray;
const vulkan = @import("vulkan.zig");

const vkGetInstanceProcAddr_t = std.meta.Child(vulkan.PFN_vkGetInstanceProcAddr);

const VulkanContext = struct {
    const Self = @This();

    entry: Entry,
    instance: Instance,

    fn init() !Self {
        var entry = try Entry.init();
        const instance = try Instance.init(&entry);

        return .{
            .entry = entry,
            .instance = instance,
        };
    }

    fn deinit(self: *Self) void {
        self.instance.deinit();
        self.entry.deinit();
    }
};

const Entry = struct {
    const Self = @This();

    const libraryName = switch (builtin.os.tag) {
        .macos => "libvulkan.1.dylib",
        else => unreachable,
    };

    handle: std.DynLib,
    vkGetInstanceProcAddr: vkGetInstanceProcAddr_t,

    fn init() !Self {
        var library = try std.DynLib.open(libraryName);
        const vkGetInstanceProcAddr = library.lookup(vkGetInstanceProcAddr_t, "vkGetInstanceProcAddr") orelse {
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

    fn getProcAddr(self: *Self, instance: ?vulkan.VkInstance, comptime name: []const u8) std.meta.Child(@field(vulkan, "PFN_" ++ name)) {
        return @as(std.meta.Child(@field(vulkan, "PFN_" ++ name)), @ptrCast(self.vkGetInstanceProcAddr(instance orelse null, @ptrCast(&name[0]))));
    }
};

const Instance = struct {
    const Self = @This();

    const instanceExtensions = switch (builtin.os.tag) {
        .macos => &[_][*]const u8{"VK_KHR_portability_enumeration"},
        else => unreachable,
    };

    const instanceFlags = switch (builtin.os.tag) {
        .macos => vulkan.VK_INSTANCE_CREATE_ENUMERATE_PORTABILITY_BIT_KHR,
        else => unreachable,
    };

    handle: vulkan.VkInstance,
    entry: *Entry,
    vkDestroyInstance: std.meta.Child(vulkan.PFN_vkDestroyInstance),

    fn init(entry: *Entry) !Self {
        const vkCreateInstance = entry.getProcAddr(null, "vkCreateInstance");

        const instanceCreateInfo = std.mem.zeroInit(vulkan.VkInstanceCreateInfo, .{
            .sType = vulkan.VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
            .enabledExtensionCount = instanceExtensions.len,
            .ppEnabledExtensionNames = instanceExtensions.ptr,
            .flags = instanceFlags,
        });

        var instance: vulkan.VkInstance = undefined;
        const status = vkCreateInstance(&instanceCreateInfo, null, &instance);
        switch (status) {
            vulkan.VK_SUCCESS => {},
            vulkan.VK_ERROR_OUT_OF_HOST_MEMORY => return error.OutOfHostMemory,
            vulkan.VK_ERROR_OUT_OF_DEVICE_MEMORY => return error.OutOfDeviceMemory,
            vulkan.VK_ERROR_INITIALIZATION_FAILED => return error.InitializationFailed,
            vulkan.VK_ERROR_LAYER_NOT_PRESENT => return error.LayerNotPresent,
            vulkan.VK_ERROR_EXTENSION_NOT_PRESENT => return error.ExtensionNotPresent,
            vulkan.VK_ERROR_INCOMPATIBLE_DRIVER => return error.IncompatibleDriver,
            else => return error.UnknownVkResult,
        }

        const vkDestroyInstance = entry.getProcAddr(instance, "vkDestroyInstance");
        return .{
            .handle = instance,
            .vkDestroyInstance = vkDestroyInstance,
            .entry = entry,
        };
    }

    fn deinit(self: *Self) void {
        self.vkDestroyInstance(self.handle, null);
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
