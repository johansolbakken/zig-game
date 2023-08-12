const RenderApi = @import("renderapi.zig");
const OpenGLVertexBuffer = @import("../platform/opengl/openglvertexbuffer.zig").OpenGLVertexBuffer;

pub const VertexBuffer = struct {
    pub const Self = @This();

    glImpl: OpenGLVertexBuffer = undefined,

    pub fn init(
        vertices: []const f32,
        size: usize,
    ) !Self {
        switch (RenderApi.api) {
            .OpenGL => return .{ .glImpl = OpenGLVertexBuffer.init(vertices, size) },
            else => return error.UnsupportedRenderApiVertexBuffer,
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
};
