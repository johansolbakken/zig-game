const std = @import("std");
const Window = @import("window.zig").Window;
const Renderer = @import("../renderer/renderer.zig").Renderer;
const RenderCommand = @import("../renderer/rendercommand.zig");
const Input = @import("input.zig");

pub const Application = struct {
    const Self = @This();

    window: Window,
    renderer: Renderer,

    pub fn init() !Self {
        const window = try Window.init("My game", 800, 600);
        const renderer = try Renderer.init();

        return .{
            .window = window,
            .renderer = renderer,
        };
    }

    pub fn deinit(self: *Self) void {
        self.renderer.deinit();
        self.window.deinit();
    }

    pub fn run(self: *Self) !void {
        while (!self.window.shouldClose()) {
            RenderCommand.setClearColor(0.1, 0.1, 0.1, 1.0);
            RenderCommand.clear();

            if (Input.isKeyPressed(Input.Key.Escape)) {
                std.log.info("Escape pressed\n", .{});
            }

            self.window.update();
        }
    }
};
