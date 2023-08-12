const std = @import("std");
const Window = @import("window.zig").Window;
const Renderer = @import("renderer.zig").Renderer;

pub fn main() !void {
    var window = try Window.init("Hello World!", 800, 600);
    defer window.deinit();

    var renderer = try Renderer.init();
    defer renderer.deinit();

    while (!window.shouldClose()) {
        window.update();
    }
}
