const Application = @import("application.zig").Application;

pub fn main() !void {
    var app = try Application.init();
    defer app.deinit();
    try app.run();
}
