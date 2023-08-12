const opengl = @import("opengl.zig");

pub const OpenGLVertexBuffer = struct {
    const Self = @This();

    rendererId: u32,

    pub fn init(
        vertices: []const f32,
        size: usize,
    ) Self {
        var rendererId: u32 = undefined;
        opengl.genBuffers(1, &rendererId);
        opengl.bindBuffer(opengl.BufferBindingTarget.ArrayBuffer, rendererId);
        opengl.bufferData(
            opengl.BufferBindingTarget.ArrayBuffer,
            @intCast(size),
            @ptrCast(@constCast(vertices)),
            opengl.BufferUsage.StaticDraw,
        );
        return .{
            .rendererId = rendererId,
        };
    }

    pub fn deinit(self: *Self) void {
        opengl.deleteBuffers(1, &self.rendererId);
    }

    pub fn bind(self: *const Self) void {
        opengl.bindBuffer(opengl.BufferBindingTarget.ArrayBuffer, self.rendererId);
    }
};
