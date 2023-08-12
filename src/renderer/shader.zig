const RenderApi = @import("renderapi.zig");
const OpenGLShader = @import("../platform/opengl/openglshader.zig").OpenGLShader;

pub const Shader = struct {
    const Self = @This();

    glImpl: OpenGLShader = undefined,

    pub fn init(code: []const u8) !Self {
        switch (RenderApi.api) {
            .OpenGL => return .{ .glImpl = try OpenGLShader.init(code) },
            else => return error.UnsupportedApi,
        }
    }
};
