const RenderApi = @import("renderapi.zig");
const OpenGLIndexBuffer = @import("../platform/opengl/openglindexbuffer.zig").OpenGLIndexBuffer;

pub const IndexBuffer = struct {
    pub const Self = @This();

    glImpl: OpenGLIndexBuffer = undefined,

    pub fn init(
        indices: []const u32,
        count: u32,
    ) !Self {
        switch (RenderApi.api) {
            .OpenGL => return .{ .glImpl = OpenGLIndexBuffer.init(indices, count) },
            else => return error.UnsupportedRenderApiIndexBuffer,
        }
    }

    pub fn deinit(self: *Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.deinit(),
            else => unreachable,
        }
    }

    pub fn bind(self: *const Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.bind(),
            else => unreachable,
        }
    }

    pub fn getCount(self: *const Self) u32 {
        switch (RenderApi.api) {
            .OpenGL => return self.glImpl.getCount(),
            else => unreachable,
        }
    }
};
