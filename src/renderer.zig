const std = @import("std");
const glad = @cImport(@cInclude("glad/glad.h"));
const glfw3 = @import("glfw3.zig");
const glinit = @cImport(@cInclude("platform/opengl/glinit.h"));

pub const Renderer = struct {
    const Self = @This();
    pub fn init() !Self {
        if (glinit.initGlad() != 0) {
            return error.FailedToInitGlad;
        }

        return .{};
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }
};
