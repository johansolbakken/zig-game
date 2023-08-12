const std = @import("std");

pub const Layer = struct {
    const Self = @This();
    onAttach: fn (self: *Self) void,
    onDetach: fn (self: *Self) void,
    onUpdate: fn (self: *Self, ts: u64) void,
    onImguiRender: fn (self: *Self) void,
    onEvent: fn (self: *Self) void,
};

pub const LayerStack = struct {
    pub const Self = @This();

    layers: std.ArrayList(*Layer),

    pub fn init(allocator: std.mem.Allocator) !Self {
        const layers = std.ArrayList(*Layer).init(allocator);
        return .{
            .layers = layers,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    pub fn pushLayer(self: *Self, layer: *Layer) !void {
        try self.layers.append(layer);
    }

    pub fn layerCount(self: *const Self) usize {
        return self.layers.items.len;
    }

    pub fn layerAt(self: *const Self, index: usize) *Layer {
        return self.layers.items[index];
    }
};
