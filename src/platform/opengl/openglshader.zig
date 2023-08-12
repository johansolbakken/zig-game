const std = @import("std");

const ShaderType = enum {
    Unknown,
    Vertex,
    Fragment,
};

pub const OpenGLShader = struct {
    const Self = @This();

    rendererId: u32,

    pub fn init(code: []const u8) !Self {
        var gpa = std.heap.GeneralPurposeAllocator(.{}){};

        var vertexSource: []const u8 = "";
        var fragmentSource: []const u8 = "";

        var shaderType = ShaderType.Unknown;

        var lines = std.mem.split(u8, code, "\n");
        while (lines.next()) |line| {
            if (std.mem.eql(u8, line, "#shader vertex")) {
                shaderType = ShaderType.Vertex;
            } else if (std.mem.eql(u8, line, "#shader fragment")) {
                shaderType = ShaderType.Fragment;
            } else {
                switch (shaderType) {
                    .Vertex => {
                        vertexSource = try std.mem.concat(gpa.allocator(), u8, &[_][]const u8{ vertexSource, line, "\n" });
                    },
                    .Fragment => {
                        fragmentSource = try std.mem.concat(gpa.allocator(), u8, &[_][]const u8{ fragmentSource, line, "\n" });
                    },
                    else => {},
                }
            }
        }

        const rendererId = try compile(vertexSource, fragmentSource);

        return .{
            .rendererId = rendererId,
        };
    }

    fn compile(vertexSrc: []const u8, fragmentSrc: []const u8) !u32 {
        _ = fragmentSrc;
        _ = vertexSrc;
        return 0;
    }
};
