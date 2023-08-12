const RenderCommand = @import("rendercommand.zig");

pub const Renderer = struct {
    const Self = @This();
    pub fn init() !Self {
        try RenderCommand.init();
        return .{};
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }
};
