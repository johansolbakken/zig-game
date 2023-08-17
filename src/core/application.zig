const std = @import("std");
const Window = @import("window.zig").Window;
const Renderer = @import("../renderer/renderer.zig");
const RenderCommand = Renderer.RenderCommand;
const Renderer2D = Renderer.Renderer2D;
const Input = @import("input.zig");

pub const Application = struct {
    const Self = @This();

    window: Window,

    pub fn init() !Self {
        const window = try Window.init("My game", 800, 600);
        try Renderer.init();

        return .{
            .window = window,
        };
    }

    pub fn deinit(self: *Self) void {
        Renderer.deinit();
        self.window.deinit();
    }

    pub fn run(self: *Self) !void {
        while (!self.window.shouldClose()) {
            RenderCommand.setClearColor(0.1, 0.1, 0.1, 1.0);
            RenderCommand.clear();
            self.window.update();
        }
    }
};
