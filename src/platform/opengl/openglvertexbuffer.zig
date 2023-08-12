pub const OpenGLVertexBuffer = struct {
    const Self = @This();

    pub fn init(
        vertices: []const f32,
        size: usize,
    ) Self {
        _ = size;
        _ = vertices;
        return .{};
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }
};
