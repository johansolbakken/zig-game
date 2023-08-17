pub const RenderCommand = @import("rendercommand.zig");
pub const Renderer2D = @import("renderer2d.zig");

pub fn init() !void {
    try RenderCommand.init();
    try Renderer2D.init();
}

pub fn deinit() void {
    Renderer2D.deinit();
    RenderCommand.deinit();
}
