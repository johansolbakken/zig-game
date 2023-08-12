const opengl = @import("../platform/opengl/opengl.zig");

pub fn init() !void {
    try opengl.init();
}
