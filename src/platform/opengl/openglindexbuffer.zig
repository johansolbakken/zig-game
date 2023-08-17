const opengl = @import("opengl.zig");
const std = @import("std");

pub const OpenGLIndexBuffer = struct {
    const Self = @This();

    rendererId: u32,
    count: u32,

    pub fn init(
        indices: []const u32,
        count: u32,
    ) Self {
        var rendererId: u32 = 0;
        opengl.genBuffers(1, &rendererId);
        opengl.bindBuffer(opengl.BufferBindingTarget.ElementArrayBuffer, rendererId);
        opengl.bufferData(
            opengl.BufferBindingTarget.ElementArrayBuffer,
            @intCast(count * @sizeOf(u32)),
            @ptrCast(@constCast(indices)),
            opengl.BufferUsage.StaticDraw,
        );
        return .{
            .rendererId = rendererId,
            .count = count,
        };
    }

    pub fn deinit(self: *Self) void {
        opengl.deleteBuffers(1, &self.rendererId);
    }

    pub fn bind(self: *const Self) void {
        opengl.bindBuffer(opengl.BufferBindingTarget.ElementArrayBuffer, self.rendererId);
    }

    pub fn getCount(self: *const Self) u32 {
        return self.count;
    }
};
