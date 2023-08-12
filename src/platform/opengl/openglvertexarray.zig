const opengl = @import("opengl.zig");

pub const OpenGLVertexArray = struct {
    const Self = @This();

    rendererId: u32,

    pub fn init() Self {
        var rendererId: u32 = 0;
        opengl.genVertexArrays(1, &rendererId);
        return .{
            .rendererId = rendererId,
        };
    }

    pub fn deinit(self: *Self) void {
        opengl.deleteVertexArrays(1, &self.rendererId);
    }

    pub fn bind(self: *Self) void {
        opengl.bindVertexArray(self.rendererId);
    }

    pub fn unbind(self: *Self) void {
        _ = self;
        opengl.bindVertexArray(0);
    }
};
