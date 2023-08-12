const std = @import("std");
const Window = @import("window.zig").Window;

pub fn main() !void {
    var window = try Window.init("Hello World!", 800, 600);
    defer window.deinit();

    while (!window.shouldClose()) {
        window.update();
    }
}
