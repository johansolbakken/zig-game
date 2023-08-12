const std = @import("std");
const opengl = @import("opengl.zig");

const ShaderType = enum {
    Unknown,
    Vertex,
    Fragment,
};

pub const OpenGLShader = struct {
    const Self = @This();

    rendererId: u32,

    pub fn init(vertexSrc: []const u8, fragmentSrc: []const u8) !Self {
        const rendererId = try compile(vertexSrc, fragmentSrc);
        return .{
            .rendererId = rendererId,
        };
    }

    pub fn deinit(self: *const Self) void {
        opengl.deleteProgram(self.rendererId);
    }

    fn compile(vertexSrc: []const u8, fragmentSrc: []const u8) !u32 {
        var vertex = opengl.createShader(opengl.ShaderType.Vertex);
        defer opengl.deleteShader(vertex);
        opengl.shaderSource(vertex, vertexSrc);
        try opengl.compileShader(vertex);

        var fragment = opengl.createShader(opengl.ShaderType.Fragment);
        defer opengl.deleteShader(fragment);
        opengl.shaderSource(fragment, fragmentSrc);
        try opengl.compileShader(fragment);

        var program = opengl.createProgram();
        opengl.attachShader(program, vertex);
        opengl.attachShader(program, fragment);
        try opengl.linkProgram(program);

        return program;
    }

    pub fn bind(self: *const Self) void {
        opengl.useProgram(self.rendererId);
    }

    pub fn setVec3(self: *const Self, name: []const u8, vec: @Vector(3, f32)) void {
        const location = opengl.getUniformLocation(self.rendererId, name);
        opengl.uniform3f(location, vec[0], vec[1], vec[2]);
    }
};
