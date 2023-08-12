const Window = @import("window.zig").Window;
const Renderer = @import("../renderer/renderer.zig").Renderer;

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
            self.window.update();
        }
    }
};
