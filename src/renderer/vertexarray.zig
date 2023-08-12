const RenderApi = @import("renderapi.zig");
const OpenGLVertexArray = @import("../platform/opengl/openglvertexarray.zig").OpenGLVertexArray;

pub const VertexArray = struct {
    pub const Self = @This();

    glImpl: OpenGLVertexArray = undefined,

    pub fn init() !Self {
        switch (RenderApi.api) {
            .OpenGL => return .{ .glImpl = OpenGLVertexArray.init() },
            else => return error.UnsupportedRenderApiVertexBuffer,
        }
    }

    pub fn deinit(self: *Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.deinit(),
            else => unreachable,
        }
    }

    pub fn bind(self: *Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.bind(),
            else => unreachable,
        }
    }

    pub fn unbind(self: *Self) void {
        _ = self;
        switch (RenderApi.api) {
            .OpenGL => OpenGLVertexArray.unbind(),
            else => unreachable,
        }
    }
};
