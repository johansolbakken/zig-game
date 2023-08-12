const RenderApi = @import("renderapi.zig");
const OpenGLShader = @import("../platform/opengl/openglshader.zig").OpenGLShader;

pub const Shader = struct {
    const Self = @This();

    glImpl: OpenGLShader = undefined,

    pub fn init(vertexSrc: []const u8, fragmentSrc: []const u8) !Self {
        switch (RenderApi.api) {
            .OpenGL => return .{ .glImpl = try OpenGLShader.init(vertexSrc, fragmentSrc) },
            else => return error.UnsupportedApi,
        }
    }

    pub fn bind(self: *const Self) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.bind(),
            else => unreachable,
        }
    }
};
