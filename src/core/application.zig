const std = @import("std");
const Window = @import("window.zig").Window;
const Renderer = @import("../renderer/renderer.zig").Renderer;
const RenderCommand = @import("../renderer/rendercommand.zig");
const Input = @import("input.zig");

const VertexArray = @import("../renderer/vertexarray.zig").VertexArray;
const VertexBuffer = @import("../renderer/vertexbuffer.zig").VertexBuffer;
const Shader = @import("../renderer/shader.zig").Shader;

const opengl = @import("../platform/opengl/opengl.zig");

const simpleVert = @embedFile("../shaders/simple.vert");
const simpleFrag = @embedFile("../shaders/simple.frag");

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
        const vertices = [_]f32{
            -0.5, -0.5, 0.0,
            0.5,  -0.5, 0.0,
            0.0,  0.5,  0.0,
        };

        var va = try VertexArray.init();
        defer va.deinit();
        va.bind();

        var vb = try VertexBuffer.init(&vertices, 3 * 3 * @sizeOf(u32));
        defer vb.deinit();
        vb.bind();

        opengl.enableVertexAttribArray(0);
        opengl.vertexAttribPointer(0, 3, opengl.GLType.Float, false, 3 * @sizeOf(f32), 0);

        const shader = try Shader.init(simpleVert, simpleFrag);

        while (!self.window.shouldClose()) {
            RenderCommand.setClearColor(0.1, 0.1, 0.1, 1.0);
            RenderCommand.clear();

            shader.bind();
            RenderCommand.drawIndexed(&va, 3);

            self.window.update();
        }
    }
};
