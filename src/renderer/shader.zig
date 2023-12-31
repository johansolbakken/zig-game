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

    pub fn setVec3(self: *const Self, name: []const u8, vec: @Vector(3, f32)) void {
        switch (RenderApi.api) {
            .OpenGL => self.glImpl.setVec3(name, vec),
            else => unreachable,
        }
    }
};
